//
//  User.swift
//  Quiz App
//
//  Created by Edit Station 3 on 12/4/15.
//  Copyright © 2015 Ric Murray Studio. All rights reserved.
//

import UIKit
import Parse

let passPercent : Float = 0.6



class User: PFUser {
    
    @NSManaged var name : String
    
    private var videosWatched : [String] = []
    private var quizResults : [String : Float] = [:]
    
    var hasLoadedData = false
    
    func completedVideo(lesson : Lesson) {
        if !self.hasWatchedVideo(lesson) {
            self.videosWatched.append(lesson.objectId!)
            let wv = WatchedVideo()
            wv.user = User.currentUser()!
            wv.lesson = lesson
            wv.saveEventually()
        }
    }
    
    func hasWatchedVideo(lesson : Lesson) -> Bool {
        return self.videosWatched.contains(lesson.objectId!)
    }
    
    func completedQuiz(lesson : Lesson, percent: Float) {
        let oldResults = self.quizResultsForLesson(lesson)
        
        if oldResults == nil {
            self.quizResults[lesson.objectId!] = percent
            let qr = QuizResult()
            qr.user = User.currentUser()!
            qr.lesson = lesson
            qr.score = percent
            qr.saveEventually()
        } else if percent > oldResults {
            //find the old object and update it
            QuizResult.getQuizResultsForLesson(lesson, block: { (quizResult, error) in
                if quizResult != nil {
                    quizResult!.score = percent
                    quizResult!.saveEventually()
                }
            })
            
        }
       
    }
    
    func quizResultsForLesson(lesson: Lesson) -> Float? {
        return quizResults[lesson.objectId!]
    }
    
    func hasPassedQuiz(lesson: Lesson) -> Bool {
        return self.quizResultsForLesson(lesson) >= passPercent
    }
    
    func canTakeFinalForCourse(course : Course) -> Bool {
        for lesson in course.lessons {
            if lesson.isFinal {
                //ignore the final
            } else if !self.hasFullyCompletedLesson(lesson) {
                return false
            }
        }
        
        return true
    }
    
    func hasPassedFinalForCourse(course : Course) -> Bool {

        return self.hasFullyCompletedLesson(course.lessons.last!)
        
    }

    
    func hasFullyCompletedLesson(lesson : Lesson) -> Bool{
        if lesson.movieURL != nil {
            if !self.hasWatchedVideo(lesson) {
                return false
            }
        }
        
        if lesson.hasQuiz {
            if !self.hasPassedQuiz(lesson) {
                return false
            }
        }
        
        return true
    }
    
    func getWatchedVideosAndQuizResults() {
        var query = WatchedVideo.query()!
        query.whereKey("user", equalTo: self)
        query.limit = 1000
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            let wVids = objects as! [WatchedVideo]?
            
            if wVids != nil && wVids!.count > 0 {
                for video in wVids! {
                    self.videosWatched.append(video.lesson.objectId!)
                }
            }
            
            //got the videos, now get the quiz data
            query = QuizResult.query()!
            query.whereKey("user", equalTo: self)
            query.limit = 1000
            query.findObjectsInBackgroundWithBlock({ (objects, error) in
                let qResults = objects as! [QuizResult]?
                
                if qResults != nil && qResults!.count > 0 {
                    for result in qResults! {
                        self.quizResults[result.lesson.objectId!] = result.score
                    }
                }
                
                self.hasLoadedData = true
                
            })
        }
    }
    

}
