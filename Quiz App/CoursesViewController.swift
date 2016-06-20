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

class CoursesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var buttonClickSoundPlayer:AVAudioPlayer!
    
    
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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBarHidden = true
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let userLoginStored = NSUserDefaults.standardUserDefaults().boolForKey("isUserLogin")
        
        if userLoginStored == true {
            return
        }else{
            self.performSegueWithIdentifier("login", sender: self)
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CourseManager.sharedInstance.courses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell") as! LessonTableViewCell
        cell.course = CourseManager.sharedInstance.courses[indexPath.row]
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
            let course = CourseManager.sharedInstance.courses[indexPath.row]
            CourseManager.sharedInstance.currentCourse = course
            self.buttonClickSoundPlayer.play()
        }
    }
    

}
