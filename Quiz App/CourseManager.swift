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
    private var selectedCourseIndex = 0
    
    class var sharedInstance : CourseManager {
        return sharedCourseManager
    }
    
    var courses : [Course] {
             // Get an NSURL object pointing to the json file in our app bundle
            let jsonPath:String = NSBundle.mainBundle().pathForResource("PT App", ofType: "json")!
            let urlPath:NSURL = NSURL(fileURLWithPath: jsonPath)
            let jsonData:NSData = NSData(contentsOfURL: urlPath)!

            do {
                let arrayOfDictionaries: [NSDictionary] = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! [NSDictionary]
                return arrayOfDictionaries.map({Course(jsonDictionary: $0)})
            }
            catch {
                // There was an error parsing the json file
                print("Error Loading JSON File")
                return []
            }
    }
    
    var currentCourse : Course {
        get {
            return courses[selectedCourseIndex]
        }
        
        set(newCourse) {
            self.selectedCourseIndex = self.courses.indexOf(newCourse)!
        }
    }
}
