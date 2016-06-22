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
    
    
}
