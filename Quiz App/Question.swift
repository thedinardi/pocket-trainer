//
//  PFQuestion.swift
//  Pocket Trainer
//
//  Created by AE Tower on 6/22/16.
//  Copyright © 2016 Ric Murray Studio. All rights reserved.
//

import UIKit
import Parse

class Question: PFObject, PFSubclassing {
    
    @NSManaged var questionText: String
    @NSManaged var answers:[String]
    @NSManaged var correctAnswerIndex:Int
    @NSManaged var feedback:String
    @NSManaged var sort : Int
    @NSManaged var lesson : Lesson
    
    class func parseClassName() -> String {
        return "Question"
    }

}
