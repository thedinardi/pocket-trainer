//
//  Question.swift
//  Quiz App
//
//  Created by AE Tower on 11/9/15.
//  Copyright © 2015 Ric Murray Studio. All rights reserved.
//

import UIKit

class Question: NSObject {
    
    var questionText: String
    var answers:[String]
    var correctAnswerIndex:Int
    var feedback:String
    var index : Int = 0
    var name : String {
        return "Question \(index + 1)"
    }
    
  

    init(jsonDictionary: NSDictionary) {
        self.questionText = jsonDictionary["question"] as! String
        self.answers = jsonDictionary["answers"] as! [String]
        self.correctAnswerIndex = jsonDictionary["correctIndex"] as! Int
        self.feedback = jsonDictionary["feedback"] as! String
        
    
    }
    
    func createParseObject() -> PFQuestion {
        let question = PFQuestion()
        question.questionText = questionText
        question.answers = answers
        question.correctAnswerIndex = correctAnswerIndex
        question.feedback = feedback
        question.sort = index
        
        return question
    }
    
    
}
