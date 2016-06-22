//
//  ViewController.swift
//  Quiz App
//
//  Created by AE Tower on 11/9/15.
//  Copyright © 2015 Ric Murray Studio. All rights reserved.
//

import UIKit
import AVFoundation
import Parse

class ViewController: UIViewController {
    var lesson : Lesson!
    
    @IBOutlet weak var scrollViewContentView: UIView!
    @IBOutlet weak var moduleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    var questions:[Question] = [Question]()
    var currentQuestion:Question?
    var answerButtonArray:[AnswerButtonView] = [AnswerButtonView]()
    var userAnswers:[Question] = [Question]()
    var alertText:String = ""
    var percentCorrect = Float()

    //Score keeping
    
    var numberCorrect:Int = 0
    var quizPassed:Int = 0

    //Result view properties
    
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var resultViewTopMargin: NSLayoutConstraint!
    @IBOutlet weak var resultBG: UIImageView!
    var correctSoundPlayer:AVAudioPlayer!
    var wrongSoundPlayer:AVAudioPlayer!
    var quizPassSoundPlayer:AVAudioPlayer!
    var quizFailSoundPlayer:AVAudioPlayer!
    var buttonClickSoundPlayer:AVAudioPlayer!
    let gradient: CAGradientLayer = CAGradientLayer()
    let rightImageName = "RM Correct check.png"
    let wrongImageName = "wrongX.png"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController!.navigationBarHidden = false
        self.title = "Quiz"
        
        let signoutButon = UIBarButtonItem(title: "Sign Out", style: .Plain, target: self, action: #selector(self.signoutButtonTapped))
        self.navigationItem.rightBarButtonItem = signoutButon
        
        if self.lesson.isFinal {
            self.title = "Final Exam"
        }
        
        var title = "Would you like to take the Quiz?"
        
        if lesson.isFinal {
            title = "Would you like to take the Final Exam?"
        }

        //Quiz Alert
        let alert:UIAlertController = UIAlertController(title: title, message: alertText, preferredStyle: UIAlertControllerStyle.Alert)
        
        //Warning Alert
        let warning:UIAlertController = UIAlertController(title: "Are you sure you don't want to see the Quiz system?", message: alertText, preferredStyle: UIAlertControllerStyle.Alert)
        
        //Warning yes button & actions
        warning.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
            
            self.buttonClickSoundPlayer.play()
            self.navigationController?.popViewControllerAnimated(true)
    
        }))
        
        //Warning no button & actions
        warning.addAction(UIAlertAction(title: "No", style: .Default, handler: { (action: UIAlertAction!) in
            
            self.buttonClickSoundPlayer.play()
            self.presentViewController(alert, animated: true, completion: nil)
    
        }))
        
        //Alert yes button & actions
        alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
            (self.buttonClickSoundPlayer.play())
            
            
        }))
        
        //Alert no button & actions
        alert.addAction(UIAlertAction(title: "No", style: .Default, handler: { (action: UIAlertAction!) in
            
            self.buttonClickSoundPlayer.play()
            self.presentViewController(warning, animated: true, completion: nil)
            
            
            
        }))

        //Present Quiz Yes/No
        self.presentViewController(alert, animated: true, completion: nil)
        
        //Initialize the audio players
        do {
            let correctSoundUrl:NSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Correct answer", ofType: "mp3")!)
            self.correctSoundPlayer = try AVAudioPlayer(contentsOfURL: correctSoundUrl)
        }
        catch {
            //If some error occurs execution comes into here
        }
        do {
            let wrongSoundUrl:NSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Wrong answer", ofType: "mp3")!)
            self.wrongSoundPlayer = try AVAudioPlayer(contentsOfURL: wrongSoundUrl)
        }
        catch {
            //If some error occurs execution comes into here
        }
        do {
            let quizPassSoundUrl:NSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("quiz pass", ofType: "aif")!)
            self.quizPassSoundPlayer = try AVAudioPlayer(contentsOfURL: quizPassSoundUrl)
        }
        catch {
            //If some error occurs execution comes into here
        }
        do {
            let quizFailSoundUrl:NSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Aww", ofType: "mp3")!)
            self.quizFailSoundPlayer = try AVAudioPlayer(contentsOfURL: quizFailSoundUrl)
        }
        catch {
            //If some error occurs execution comes into here
        }
        do {
            let buttonClickSoundUrl:NSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("button click", ofType: "mp3")!)
            self.buttonClickSoundPlayer = try AVAudioPlayer(contentsOfURL: buttonClickSoundUrl)
        }
        catch {
            //If some error occurs execution comes into here
        }
        
        //Hide the dimView and result View
        
        self.dimView.alpha = 0
        self.resultView.alpha = 0
        
        //Get the questions from the quiz model
        self.questions = lesson.questions
        
        //Check if there's at least 1 question
        if self.questions.count > 0 {
            
            //Set the current question to first question
            self.currentQuestion = self.questions[0]
            
            //Call the display question method
            self.displayCurrentQuestion()
            
        }
    }

    func displayCurrentQuestion() {
        if let actualCurrentQuestion = self.currentQuestion {
            
            self.questionLabel.alpha = 0
            
            //Update the question text
            self.questionLabel.text = actualCurrentQuestion.questionText
            
            //Reveal the question
            UIView.animateWithDuration(1.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.questionLabel.alpha = 1
                
                }, completion: nil)

            //Create and display the answer button view
            self.createAnswerButtons()
        }
    }

    func createAnswerButtons() {

        var index:Int
        for index = 0; index < self.currentQuestion?.answers.count; index += 1 {
            
            //Create an answer button view
            
            let answer:AnswerButtonView = AnswerButtonView()
            answer.translatesAutoresizingMaskIntoConstraints = false
            
            //Place it into the content view
            self.scrollViewContentView.addSubview(answer)
            
            //Add a tap gesture recognizer
            
            let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.answerTapped(_:)))
            
            answer.addGestureRecognizer(tapGesture)
            
            //Add constaints depending on what number button it is
            
            
            let constantHeight = self.view.frame.height / 8
            let spacing = constantHeight / 50
        
            
            let heightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute:NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: constantHeight)
            
            answer.addConstraint(heightConstraint)
            
            let leftMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollViewContentView, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 400)

            let rightMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollViewContentView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 400)
            
            let topMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: answer, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.scrollViewContentView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: (constantHeight + spacing) * CGFloat(index))
            
            //iPad answer spacing

//            if UI_USER_INTERFACE_IDIOM() == .Pad {
//                topMarginConstraint.constant = (constantHeight + 5) * CGFloat(index)
//            }
            
            //Add constraint to content view
            self.scrollViewContentView.addConstraints([leftMarginConstraint, rightMarginConstraint, topMarginConstraint])
            
            //Set the answer text for it
            let answerText = self.currentQuestion!.answers[index]
            answer.setAnswerText(answerText)
            
            
            //Set the answer number
            answer.setAnswerNumber(index + 1)
            
            //Add it to the button array
            
            self.answerButtonArray.append(answer)
            
            //Manually call update layout
            self.view.layoutIfNeeded()
            
            //Calculate slide in delay
            
            let slideInDelay:Double = Double(index) * 0.1
            
            //animate the button constraints so that they slide in
            
            UIView.animateWithDuration(0.7, delay: slideInDelay, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                leftMarginConstraint.constant = 0
                rightMarginConstraint.constant = 0
                self.view.layoutIfNeeded()
                }, completion: nil)
        }
        
        //Adjust the height of the content view so that it can scroll if need be
        
//        let contentViewHeight:NSLayoutConstraint = NSLayoutConstraint(item: self.scrollViewContentView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.answerButtonArray[0], attribute: NSLayoutAttribute.Height, multiplier: CGFloat(self.answerButtonArray.count - 1), constant: 101)
//        
//        //Add constraint to content view
//        self.scrollViewContentView.addConstraint(contentViewHeight)
    }
    
    func answerTapped(gesture:UITapGestureRecognizer) {
        //Get access to the answer button that was tapped
        let answerButtonThatWasTapped:AnswerButtonView? = gesture.view as! AnswerButtonView?
        
        if let actualButton = answerButtonThatWasTapped {
            
            //We got the button, now find out which index it was
            
            let answerTappedIndex:Int? = self.answerButtonArray.indexOf(actualButton)
            
            if let foundAnswerIndex = answerTappedIndex {
                
                //If we found the index, compare the answer index that was tapped vs the correct index from the question
                
                if foundAnswerIndex == self.currentQuestion!.correctAnswerIndex{
                    //User got it correct!
                    
                    self.resultTitleLabel.text = "Correct"
                    
                    //Play correct sound
                    self.correctSoundPlayer.play()
                    
                    //Change background of result view and button
                    self.nextButton.backgroundColor = UIColor(red: 13/255, green: 170/255, blue: 234/255, alpha: 1)
                    self.resultView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 0.6)
                    resultTitleLabel.textColor = UIColor(red: 23/255, green: 65/255, blue: 235/255, alpha: 1)
                    feedbackLabel.text = ""
                    self.resultBG.image = UIImage(named: "RM Quiz BG.png")
                    self.resultImage.image = UIImage(named: rightImageName)
                    self.resultImage.contentMode = UIViewContentMode.ScaleAspectFill
                    
                    //Increment user score
                    self.numberCorrect += 1
                    
                }
                else {
                    //User got it wrong
                    self.resultTitleLabel.text = "Incorrect"
                
                    //Play wrong sound
                    self.wrongSoundPlayer.play()
                    
                    //Change background of result view and button
                    self.resultView.backgroundColor = UIColor(red: 85/255, green: 19/255, blue: 12/255, alpha: 0.9)
                    self.nextButton.backgroundColor = UIColor(red: 58/255, green: 0/255, blue: 16/255, alpha: 1)
                    resultTitleLabel.textColor = UIColor.whiteColor()
                    self.resultBG.image = UIImage(named: "")
                    self.resultImage.image = UIImage(named: wrongImageName)
                    self.resultImage.contentMode = UIViewContentMode.ScaleAspectFill
                    feedbackLabel.text = ""
                }
                
                //Set the button text to next
                self.nextButton.setTitle("Next", forState: UIControlState.Normal)
                
                //Set result view top margin constraint to high
                self.resultViewTopMargin.constant = 900
                self.view.layoutIfNeeded()

                //Display the dim view and the result view
                UIView.animateWithDuration(0.4, animations: {
                    
                    self.resultViewTopMargin.constant = 100
                    self.view.layoutIfNeeded()
                    
                    //Fade into view
                    self.dimView.alpha = 1
                    self.resultView.alpha = 1
                })
            }
        }
    }
    @IBAction func changeQuestion(sender: UIButton) {
        
        self.buttonClickSoundPlayer.play()

        //QUIZ FAILED
        if self.nextButton.titleLabel?.text == "Restart Quiz" && self.questions.count > 0 {
            
            //Reset the question to the first question
            self.currentQuestion = self.questions[0]
            self.displayCurrentQuestion()
            
            //Remove the dim view and result view
            self.dimView.alpha = 0
            self.resultView.alpha = 0

            //Reset the score
            self.numberCorrect = 0

            return

        }
        
        //QUIZ PASSED
        if self.nextButton.titleLabel?.text == "Review Quiz" && self.questions.count > 0 {

            //Reset the question to the first question
            self.currentQuestion = self.questions[0]
            self.displayCurrentQuestion()
            
            //Remove the dim view and result view
            self.dimView.alpha = 0
            self.resultView.alpha = 0

            //Reset the score
            self.numberCorrect = 0
            
            self.performSegueWithIdentifier("feedback", sender: self)
        }
        
        //Dismiss dim & result view
        self.dimView.alpha = 0
        self.resultView.alpha = 0
        
        //Erase the question and module labels
        self.questionLabel.text = ""
        //self.moduleLabel.text = ""
        
        //Remove all the answer buttone views
        for button in self.answerButtonArray {
            button.removeFromSuperview()
            
        }
        
        
        //Flush button array
        self.answerButtonArray.removeAll(keepCapacity: false)
        
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
            else {

                //End the quiz

                self.percentCorrect = Float(numberCorrect) / Float(actualCurrentIndex)
                User.currentUser.quizResultsForLesson(self.lesson)
                User.currentUser.completedQuiz(self.lesson, percent: percentCorrect)

                if User.currentUser.hasPassedQuiz(self.lesson) {
                
                //if percentCorrect >= passPercent {

                    self.quizPassSoundPlayer.play()
                    self.resultView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 0.6)
                    self.nextButton.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 0.8)
                    self.view.layoutIfNeeded()
                    self.resultTitleLabel.text = "Quiz Finished"
                    feedbackLabel.textColor = UIColor(red: 23/255, green: 65/255, blue: 235/255, alpha: 1)
                    self.feedbackLabel.text = String(format: "Your Score is %i / %i", self.numberCorrect, self.questions.count)
                    self.nextButton.setTitle("Review Quiz", forState: UIControlState.Normal)
                    self.resultImage.image = UIImage(named: rightImageName)
                    self.resultBG.image = UIImage(named: "RM Quiz BG.png")
                    self.dimView.alpha = 1
                    self.resultView.alpha = 1
                    
                    //COURSE COMPLETION NOTIFICATION AND EMAIL TO BE SENT
                    if User.currentUser.hasPassedFinalForCourse(CourseManager.sharedInstance.currentCourse) {
                        
                        //Quiz Alert
                        let alert = UIAlertController(title: "Congratulations!", message: "You have completed the course!  A certificate will be emailed to you.", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        
                        //Alert yes button & actions
                        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                            (self.buttonClickSoundPlayer.play())
                        }))
                        
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                    }
                    
                    
                    
                }
                else {
                    self.quizFailSoundPlayer.play()
                    self.resultView.backgroundColor = UIColor(red: 85/255, green: 19/255, blue: 12/255, alpha: 0.6)
                    self.nextButton.backgroundColor = UIColor(red: 58/255, green: 0/255, blue: 16/255, alpha: 0.8)
                    self.view.layoutIfNeeded()
                    self.resultTitleLabel.text = "Quiz Finished"
                    self.feedbackLabel.text = String(format: "Your Score is %i / %i", self.numberCorrect, self.questions.count)
                    self.feedbackLabel.textColor = UIColor.redColor()
                    self.nextButton.setTitle("Restart Quiz", forState: UIControlState.Normal)
                    self.resultImage.image = UIImage(named: wrongImageName)
                    self.dimView.alpha = 1
                    self.resultView.alpha = 1
                }
            }
        }
    }

    func signoutButtonTapped() {
        PFUser.logOut()
        print("logout successful")
        self.navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "feedback" {
            let vc = segue.destinationViewController as! FeedbackViewController
            vc.lesson = self.lesson
        }
    }


    

}

