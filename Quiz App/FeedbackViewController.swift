//
//  FeedbackViewController.swift
//  Quiz App
//
//  Created by AE Tower on 11/16/15.
//  Copyright © 2015 Ric Murray Studio. All rights reserved.
//

import UIKit
import AVFoundation
import Parse

class FeedbackViewController: UIViewController {
    var lesson: Lesson!
    var question: Question!
    @IBOutlet weak var questionLabel2: UILabel!
    @IBOutlet weak var feedbackLabel2: UILabel!
    @IBOutlet weak var nextButton2: UIButton!

    //let model:QuizModel = QuizModel()
    var questions:[Question] = [Question]()
    var currentQuestion:Question?
    var answerButtonArray:[AnswerButtonView] = [AnswerButtonView]()
    var userAnswers:[Question] = [Question]()
    var buttonClickSoundPlayer:AVAudioPlayer!
    var numberCorrect: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feedback"
        let barItem = UIBarButtonItem(title: "Lessons", style: .Plain, target: self, action: #selector(self.lessonsButtonTapped))
        self.navigationItem.leftBarButtonItem = barItem
        let signoutButon = UIBarButtonItem(title: "Sign Out", style: .Plain, target: self, action: #selector(self.signoutButtonTapped))
        self.navigationItem.rightBarButtonItem = signoutButon
        
        // Do any additional setup after loading the view, typically from a nib.
    
        do {
            
            let buttonClickSoundUrl:NSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("button click", ofType: "mp3")!)
            self.buttonClickSoundPlayer = try AVAudioPlayer(contentsOfURL: buttonClickSoundUrl)
        }
        catch {
            //If some error occurs execution comes into here
        }

        //Get the questions from the question model
        self.questions = lesson.questions!
        
        //Check if there's at least 1 question
        if self.questions.count > 0 {
            
            //Set the current question to first question
            self.currentQuestion = self.questions[0]
            
            //Load state
            //self.loadState()
            
            //Call the display question method
            self.displayCurrentQuestion()
        }
    }

    func displayCurrentQuestion() {
        
        if let actualCurrentQuestion = self.currentQuestion {
            
            self.questionLabel2.alpha = 0
            
            //Update the question text
            self.questionLabel2.text = actualCurrentQuestion.questionText
            
            //Reveal the question
            UIView.animateWithDuration(1.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.questionLabel2.alpha = 1
                
                }, completion: nil)
            
            self.feedbackLabel2.alpha = 0
            
            //Update the feedback text
            
            self.feedbackLabel2.text = self.currentQuestion!.feedback
            
            if (UI_USER_INTERFACE_IDIOM() == .Pad) {
                self.feedbackLabel2.font = UIFont.systemFontOfSize(36)
            }
            
            //Animate feedback text
            
            UIView.animateWithDuration(1.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.feedbackLabel2.alpha = 1
                
                }, completion: nil)
        }
    }
        
    func lessonsButtonTapped() {
        
        self.navigationController?.popToViewController(navigationController!.viewControllers[1], animated: true)
        //self.showNavigationBar()
    }
    
    func signoutButtonTapped() {
        PFUser.logOut()
        print("logout successful")
        self.navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)
    }

    @IBAction func nextButton2(sender: UIButton) {

        self.buttonClickSoundPlayer.play()

        //Finding current index of question
        let indexofCurrentQuestion:Int? = self.questions.indexOf(self.currentQuestion!)
        
        //Check if it found the current index
        if let actualCurrentIndex = indexofCurrentQuestion {
            
            //Found the index! Advance the index
            let nextQuestionIndex = actualCurrentIndex + 1
            
            //Check if next question index is beyond the capacity of our questions array
            if nextQuestionIndex < self.questions.count {
                
                //We can display another question
                
                self.currentQuestion = self.questions[nextQuestionIndex]
                self.displayCurrentQuestion()
                
            }
        //Change text of button to back to lessons on last question
        if nextQuestionIndex == self.questions.count - 1 {
            
            nextButton2.setTitle("Back to Lessons", forState: UIControlState.Normal)
 
        }
        //Perform segue once Back to Lessons is pushed
        if nextQuestionIndex == self.questions.count {
            
            self.navigationController?.popToViewController(navigationController!.viewControllers[1], animated: true)
        }
    }

    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }

    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         Get the new view controller using segue.destinationViewController.
         Pass the selected object to the new view controller.
    }
    */
        
        
    

}
}

