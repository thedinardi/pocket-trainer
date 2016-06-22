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

}
