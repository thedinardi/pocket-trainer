//
//  User.swift
//  Quiz App
//
//  Created by Edit Station 3 on 12/4/15.
//  Copyright © 2015 Ric Murray Studio. All rights reserved.
//

import UIKit

let passPercent : Float = 0.6

private let currentU = User()

class User: NSObject {
    
    class var currentUser : User {
        return currentU
    }
    
    override init() {
        super.init()
        self.loadData()
    }
    
    private var videosWatched : [Int] = []
    private var quizResults : [Int : Float] = [:]
    
    func completedVideo(lesson : Lesson) {
        self.videosWatched.append(lesson.id)
        self.saveData()
    }
    
    func hasWatchedVideo(lesson : Lesson) -> Bool {
        return self.videosWatched.contains(lesson.id)
    }
    
    func completedQuiz(lesson : Lesson, percent: Float) {
        //has the user already taken the quiz
//        if self.quizResultsForLesson(lesson) != nil && self.quizResultsForLesson(lesson) < percent {
//            print("user has scored higher before")
//        } else {
//            self.quizResults[lesson.id] = percent
//        }
        
        self.quizResults[lesson.id] = percent
        self.saveData()
    }
    
    func quizResultsForLesson(lesson: Lesson) -> Float? {
        return quizResults[lesson.id]
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
//        for lesson in course.lessons {
//            
//            if lesson.isFinal && self.hasFullyCompletedLesson(lesson){
//            
//                
//            }else if !self.hasFullyCompletedLesson(lesson) {
//                return false
//            }
//        }
        return self.hasFullyCompletedLesson(course.lessons.last!)
        
       //return true
    }

    
    func hasFullyCompletedLesson(lesson : Lesson) -> Bool{
        if lesson.movieURL != nil {
            if !self.hasWatchedVideo(lesson) {
                return false
            }
        }
        
        if lesson.questions != nil {
            if !self.hasPassedQuiz(lesson) {
                return false
            }
        }
        
        return true
    }
    
    
    func loadData() {
        let path = docURL.URLByAppendingPathComponent("userData.dat")
        let data = NSData(contentsOfURL: path)
        if (data != nil) {
            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data!)
            self.videosWatched = unarchiver.decodeObjectForKey("videosWatched") as! [Int]
            self.quizResults = unarchiver.decodeObjectForKey("quizResults") as! [Int : Float]
            unarchiver.finishDecoding()
            print("Finished Loading Data")
        } else {
            print("No Data Found")
        }
    }
    
    func saveData() {
        if self.videosWatched.count > 0 {
            let path = docURL.URLByAppendingPathComponent("userData.dat")
            let data = NSMutableData()
            let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
            archiver.encodeObject(videosWatched, forKey: "videosWatched")
            archiver.encodeObject(quizResults, forKey: "quizResults")
            archiver.finishEncoding()
            data.writeToURL(path, atomically: true)
            print("Finished Saving Data")
        }
    }
}
