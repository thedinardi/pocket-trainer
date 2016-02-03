//
//  Lesson.swift
//  Quiz App
//
//  Created by Edit Station 3 on 12/1/15.
//  Copyright © 2015 Ric Murray Studio. All rights reserved.
//

import UIKit

class Lesson: NSObject {
    var id : Int
    var name : String
    var movieURL : NSURL?
    var questions : [Question]?
    var image : NSURL?
 
    
    var isFinal : Bool = false
    var isLastQuestion : Bool = false
    
    
    init(jsonDictionary: NSDictionary) {
        self.id = jsonDictionary["id"] as! Int
        self.name = jsonDictionary["name"] as! String

       
        if let urlString = jsonDictionary["movieURL"] {
            self.movieURL = NSURL(string: (urlString as! String))
        }
        
        if let imgString = jsonDictionary["image"] {
            self.image = NSURL(string: (imgString as! String))
        }
        
        
        //Check this
        if let lessonName = jsonDictionary["name"] {
            self.name = lessonName as! String
        }
        
        
        if let dict = jsonDictionary["quiz"] {
            let questionsDicts = dict as! [NSDictionary]
            self.questions = []

            for (i, questionDict) in questionsDicts.enumerate() {
                let q = Question(jsonDictionary: questionDict)
                q.index = i
                self.questions!.append(q)
            }
            
        }
    }
    
}
