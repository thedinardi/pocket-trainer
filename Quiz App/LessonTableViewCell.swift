//
//  LessonTableViewCell.swift
//  Quiz App
//
//  Created by Edit Station 3 on 12/21/15.
//  Copyright © 2015 Ric Murray Studio. All rights reserved.
//

import UIKit

class LessonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    @IBOutlet weak var bgimage: UIImageView!
    var lessonsComplete:Int = 0
    var lesson : Lesson! {
        didSet {
            self.updateViewForLesson()
        }
    }
    var course : Course! {
        didSet {
            self.updateViewForCourse()
        }
    }
    
//    func updateCellBackground() {
//        
//        let imgString:String! = self.lesson.image
//        self.bgimage.image = imgString
//        
//        
//        
//    }
    
    func updateViewForLesson() {
        self.nameLabel.text = self.lesson.name
        if User.currentUser.hasFullyCompletedLesson(lesson) {
            self.checkmarkImageView.hidden = false
            self.lessonsComplete += 1
        }
        else {
            self.checkmarkImageView.hidden = true
        }
        
    }
    
    func updateViewForCourse() {
        self.nameLabel.text = self.course.name
//        if User.currentUser.hasPassedFinalForCourse(course){
//            self.checkmarkImageView.hidden = false
//            
//        }
//        else {
//            self.checkmarkImageView.hidden = true
//        }
        
    }
}
            
            
 

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

