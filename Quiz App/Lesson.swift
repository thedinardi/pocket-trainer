//
//  PFLesson.swift
//  Pocket Trainer
//
//  Created by AE Tower on 6/22/16.
//  Copyright © 2016 Ric Murray Studio. All rights reserved.
//

import UIKit
import Parse

class Lesson: PFObject, PFSubclassing {
    @NSManaged var sort : Int
    @NSManaged var name : String
    @NSManaged private var movieURLString : String
    @NSManaged var course : Course
    @NSManaged var hasQuiz : Bool
    
    var questions : [Question] = []
    
    //TODO: remove this
    var id = 0
    
    var movieURL : NSURL? {
        get {
            if movieURLString != "" {
                return NSURL(string: movieURLString)
            } else {
                return nil
            }
        }
        
        set(newURL) {
            self.movieURLString = newURL!.absoluteString
        }
    }

    var isFinal : Bool = false
    
    class func parseClassName() -> String {
        return "Lesson"
    }
    
    typealias QuestionsBlock = (questions: [Question]?, error: NSError?) -> ()
    func getQuestions(block : QuestionsBlock) {
        
        if self.questions.count > 0 {
            return block(questions: self.questions, error: nil)
        }
        
        let query = Question.query()!
        query.whereKey("lesson", equalTo: self)
        query.orderByAscending("sort")
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if objects == nil {
                block(questions: nil, error: error)
            } else {
                self.questions = objects! as! [Question]
                block(questions: self.questions, error: error)
            }
            
        }
        
    }


}
