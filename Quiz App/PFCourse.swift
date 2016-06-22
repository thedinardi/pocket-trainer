//
//  PFCourse.swift
//  Pocket Trainer
//
//  Created by AE Tower on 6/22/16.
//  Copyright © 2016 Ric Murray Studio. All rights reserved.
//

import UIKit
import Parse

class PFCourse: PFObject, PFSubclassing {
    
    @NSManaged var name : String
    @NSManaged var sort : Int
    
    class func parseClassName() -> String {
        return "Course"
    }
    
    
}
