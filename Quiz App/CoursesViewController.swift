//
//  CoursesViewController.swift
//  Quiz App
//
//  Created by Edit Station 3 on 1/13/16.
//  Copyright © 2016 Ric Murray Studio. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Parse

class CoursesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var buttonClickSoundPlayer:AVAudioPlayer!
    
    var courses : [Course] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Courses"
        // Do any additional setup after loading the view.
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        do {
            let buttonClickSoundUrl:NSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("button click", ofType: "mp3")!)
            self.buttonClickSoundPlayer = try AVAudioPlayer(contentsOfURL: buttonClickSoundUrl)
        }
        catch {
            //If some error occurs execution comes into here
        }
        
        CourseManager.sharedInstance.getCourses { (courses, error) in
            if courses != nil {
                self.courses = courses!
                self.tableView.reloadData()
            } else {
                
                //Internet alert
                let alert:UIAlertController = UIAlertController(title: "", message: "Please check your internet connection.", preferredStyle: UIAlertControllerStyle.Alert)
                
                //Alert yes button & actions
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    (self.buttonClickSoundPlayer.play())
                }))
                
                self.presentViewController(alert, animated: true, completion: nil)
                
                
            }
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBarHidden = true
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        if User.currentUser() == nil {
            self.performSegueWithIdentifier("login", sender: self)
        } else {
            //TODO: handle edge case of data not loading in time
            User.currentUser()!.getWatchedVideosAndQuizResults()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell") as! LessonTableViewCell
        cell.course = self.courses[indexPath.row]
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "lessons" {
            let indexPath = self.tableView.indexPathForSelectedRow!
            let course = self.courses[indexPath.row]
            CourseManager.sharedInstance.currentCourse = course
            self.buttonClickSoundPlayer.play()
        }
    }
    

}
