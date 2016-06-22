//
//  PFCourse.swift
//  Pocket Trainer
//
//  Created by AE Tower on 6/22/16.
//  Copyright © 2016 Ric Murray Studio. All rights reserved.
//

import UIKit
import Parse

class Course: PFObject, PFSubclassing {
    
    @NSManaged var name : String
    @NSManaged var sort : Int
    
    var lessons : [Lesson] = []
    
    class func parseClassName() -> String {
        return "Course"
    }
    
    typealias LessonsBlock = (lessons: [Lesson]?, error: NSError?) -> ()
    func getLessons(block : LessonsBlock) {
        
        if self.lessons.count > 0 {
            return block(lessons: self.lessons, error: nil)
        }
        
        let query = Lesson.query()!
        query.whereKey("course", equalTo: self)
        query.orderByAscending("sort")
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            
            if objects == nil {
                block(lessons: nil, error: error)
            } else {
                self.lessons = objects! as! [Lesson]
                block(lessons: self.lessons, error: error)
            }
            
        }
        
    }
    
}
