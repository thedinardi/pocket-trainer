//
//  VideoViewController.swift
//  Quiz App
//
//  Created by AnimTower on 11/19/15.
//  Copyright © 2015 Ric Murray Studio. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Crashlytics

class VideoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
        var course : Course!


        @IBOutlet weak var tableView: UITableView!
    
        var avPlayerViewController:AVPlayerViewController!
    
        var selectedLesson : Lesson?
    
        var buttonClickSoundPlayer:AVAudioPlayer!
    
        var alertText : String = ""

        @IBOutlet weak var courseLabel: UILabel!
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            self.navigationController!.navigationBarHidden = false
            self.title = "Lessons"
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "videoFinished", name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
            
            self.updateCourseLabel()
            
            
            do {
                
                
                let buttonClickSoundUrl:NSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("button click", ofType: "mp3")!)
                
                self.buttonClickSoundPlayer = try AVAudioPlayer(contentsOfURL: buttonClickSoundUrl)
                
            }
            catch {
                
                //If some error occurs execution comes into here
                
            }
            
            let button = UIButton(type: UIButtonType.RoundedRect)
            button.frame = CGRectMake(20, 50, 100, 30)
            button.setTitle("Crash", forState: UIControlState.Normal)
            button.addTarget(self, action: "crashButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
            view.addSubview(button)

        }
    
    @IBAction func crashButtonTapped(sender: AnyObject) {
        Crashlytics.sharedInstance().crash()
    }


    func updateCourseLabel () {
        
        self.courseLabel.text = CourseManager.sharedInstance.currentCourse.name
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        self.navigationController!.navigationBarHidden = false
    }
 
    
        deinit {
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        // Stop the movie player first
        func videoFinished (){
            print("Video Finished")
            User.currentUser.completedVideo(self.selectedLesson!)
        
            
            if self.selectedLesson!.questions != nil {
                self.performSegueWithIdentifier("showQuiz", sender: nil)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            
            else {
                
                self.dismissViewControllerAnimated(true) { () -> Void in

                }
            }
            

        }
    
    func playVideo(row: Int) {
        
        self.buttonClickSoundPlayer.play()
        
        self.selectedLesson = CourseManager.sharedInstance.currentCourse.lessons[row]
        let movieURL = self.selectedLesson!.movieURL
        
        if self.selectedLesson!.isFinal != true {
            
            self.avPlayerViewController = AVPlayerViewController()
            self.avPlayerViewController.player = AVPlayer(URL: movieURL!)
            self.presentViewController(avPlayerViewController, animated: true) { () -> Void in
                self.avPlayerViewController.player!.play()
            }
            
        } else {
            
            if !User.currentUser.canTakeFinalForCourse(CourseManager.sharedInstance.currentCourse) {
                
                //show prompt to user explaining they need to complete other quizzes
                
                let title = "You must complete all previous lessons to take the Final Exam."
                
                
                //Quiz Alert
                let alert:UIAlertController = UIAlertController(title: title, message: alertText, preferredStyle: UIAlertControllerStyle.Alert)
                
                
                //Alert yes button & actions
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    (self.buttonClickSoundPlayer.play())
                    
                    
                }))
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            else {
                
                self.performSegueWithIdentifier("showQuiz", sender: nil)
            }
            
            
        }

    

//        func playVideo(row: Int) {
//
//            self.buttonClickSoundPlayer.play()
//
//            self.selectedLesson = CourseManager.sharedInstance.currentCourse.lessons[row]
//            let movieURL = self.selectedLesson!.movieURL
//            
//            if movieURL != nil {
//            
//                self.avPlayerViewController = AVPlayerViewController()
//                self.avPlayerViewController.player = AVPlayer(URL: movieURL!)
//                self.presentViewController(avPlayerViewController, animated: true) { () -> Void in
//                    self.avPlayerViewController.player!.play()
//                }
//
//            } else {
//
//                if self.selectedLesson!.isFinal && !User.currentUser.canTakeFinalForCourse(CourseManager.sharedInstance.currentCourse) {
//                    
//                    //show prompt to user explaining they need to complete other quizzes
//                    
//                    let title = "You must complete all previous lessons to take the Final Exam."
//                    
//                    
//                    //Quiz Alert
//                    let alert:UIAlertController = UIAlertController(title: title, message: alertText, preferredStyle: UIAlertControllerStyle.Alert)
//                    
//                    
//                    //Alert yes button & actions
//                    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
//                        (self.buttonClickSoundPlayer.play())
//                        
//                        
//                    }))
//                    
//                    self.presentViewController(alert, animated: true, completion: nil)
//    
//                }
//                else {
//                    
//                    self.performSegueWithIdentifier("showQuiz", sender: nil)
//                }
//                
//
//            }
    

            
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showQuiz" {
            let vc = segue.destinationViewController as! ViewController
            vc.lesson = self.selectedLesson
        }
    }

    // MARK: - UITableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CourseManager.sharedInstance.currentCourse.lessons.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LessonCell") as! LessonTableViewCell
        let lesson = CourseManager.sharedInstance.currentCourse.lessons[indexPath.row]
        cell.lesson = lesson
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.playVideo(indexPath.row)
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }

}