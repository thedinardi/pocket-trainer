//
//  CourseManager.swift
//  Quiz App
//
//  Created by Edit Station 3 on 12/1/15.
//  Copyright © 2015 Ric Murray Studio. All rights reserved.
//

import UIKit

private let sharedCourseManager = CourseManager()

class CourseManager: NSObject {
    private var selectedCourse : Course?
    
    class var sharedInstance : CourseManager {
        return sharedCourseManager
    }
    
    typealias CoursesBlock = (courses: [Course]?, error: NSError?) -> ()
    
    func getCourses(block : CoursesBlock) {
        let query = Course.query()!
        query.findObjectsInBackgroundWithBlock({ (objects, error) in
            let courses = objects as! [Course]?
            block(courses: courses, error: error)
        })
    }
    
    var currentCourse : Course! {
        get {
            return selectedCourse
        }
        
        set(newCourse) {
            self.selectedCourse = newCourse
        }
    }
}
