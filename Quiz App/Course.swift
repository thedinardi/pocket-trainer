//
//  Course.swift
//  Quiz App
//
//  Created by Edit Station 3 on 12/1/15.
//  Copyright © 2015 Ric Murray Studio. All rights reserved.
//

import UIKit

class Course: NSObject {
    var name : String
    var lessons : [Lesson]
  
    
    init(jsonDictionary: NSDictionary) {
        //self.id = jsonDictionary["id"] as! Int
        self.name = jsonDictionary["name"] as! String
        let lessonsDicts = jsonDictionary["lessons"] as! [NSDictionary]
//        self.lessons = []
//        for lessonDict in lessons {
//            self.lessons.append(Lesson(jsonDictionary: lessonDict))
//        }
        self.lessons = lessonsDicts.map({Lesson(jsonDictionary: $0)})
        self.lessons.last!.isFinal = true
        
        
        
    }

    func isLastLesson(lesson: Lesson) -> Bool {
        if self.lessons.last! == lesson {
            return true
        } else {
            return false
        }
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if self.name == object?.name {
            return true
        } else {
            return false
        }
    }

}
