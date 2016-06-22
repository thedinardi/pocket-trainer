//
//  Course.swift
//  Quiz App
//
//  Created by Edit Station 3 on 12/1/15.
//  Copyright © 2015 Ric Murray Studio. All rights reserved.
//

import UIKit
import Parse

class Course: NSObject {
    var name : String
    var lessons : [Lesson]
  
    
    init(jsonDictionary: NSDictionary) {
        //self.id = jsonDictionary["id"] as! Int
        self.name = jsonDictionary["name"] as! String
        let lessonsDicts = jsonDictionary["lessons"] as! [NSDictionary]
        self.lessons = lessonsDicts.map({Lesson(jsonDictionary: $0)})
        self.lessons.last!.isFinal = true
        super.init()
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
    
    func saveInParse() {
        let course = PFCourse()
        course.name = self.name
        course.saveInBackgroundWithBlock { (success, error) in
            if success {
                print("the course is now in parse")
                
                let pfLessons = self.lessons.map({$0.createParseObject()})
                
                for lesson in pfLessons {
                    lesson.course = course
                }
                
                
                PFObject.saveAllInBackground(pfLessons, block: { (sucess, error) in
                    if success {
                        print("all lessons have been saved")
                        
                        var pfQuestions : [PFQuestion] = []
                        for (i,pfLesson) in pfLessons.enumerate() {
                            let lesson = self.lessons[i]
                            
                            if lesson.questions != nil {
                                for question in lesson.questions! {
                                    let pfQ = question.createParseObject()
                                    pfQ.lesson = pfLesson
                                    pfQuestions.append(pfQ)
                                }
                            }
                        }
                        
                        PFObject.saveAllInBackground(pfQuestions, block: { (success, error) in
                            if success {
                                print("All questions have been saved")
                            }
                        })
                        
                    }
                })
                
//                for lesson in self.lessons {
//                    pfLessons.append(lesson.createParseObject())
//                }
                
                
            }
        }
    }

}
