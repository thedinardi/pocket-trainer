//
//  QuizResults.swift
//  Pocket Trainer
//
//  Created by AE Tower on 6/24/16.
//  Copyright © 2016 Ric Murray Studio. All rights reserved.
//

import UIKit
import Parse

class QuizResult: PFObject, PFSubclassing {
    
    @NSManaged var user : User
    @NSManaged var lesson : Lesson
    @NSManaged var score : Float
    
    class func parseClassName() -> String {
        return "QuizResult"
    }
    
    typealias QuizResultBlock = (quizResult: QuizResult?, error: NSError?) -> ()
    class func getQuizResultsForLesson(lesson: Lesson, block : QuizResultBlock) {
        let query = QuizResult.query()!
        query.whereKey("user", equalTo: User.currentUser()!)
        query.whereKey("lesson", equalTo: lesson)
        query.getFirstObjectInBackgroundWithBlock { (object, error) in
            let result = object as! QuizResult?
            block(quizResult: result, error: error)
        }
    }
    
}