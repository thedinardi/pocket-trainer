//
//  WatchedVideo.swift
//  Pocket Trainer
//
//  Created by AE Tower on 6/24/16.
//  Copyright © 2016 Ric Murray Studio. All rights reserved.
//

import UIKit
import Parse

class WatchedVideo: PFObject, PFSubclassing {
    
    @NSManaged var user : User
    @NSManaged var lesson : Lesson
    
    class func parseClassName() -> String {
        return "WatchedVideo"
    }
    

}
