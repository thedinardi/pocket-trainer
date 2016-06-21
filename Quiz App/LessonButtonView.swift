//
//  LessonButtonView.swift
//  Quiz App
//
//  Created by AE Tower on 12/4/15.
//  Copyright © 2015 Ric Murray Studio. All rights reserved.
//

import UIKit

class LessonButtonView: UIView {
    
    let lessonLabel:UILabel = UILabel()
    let answerNumberLabel:UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame:frame)
        
        //Set background and alpha
        self.backgroundColor = UIColor.greenColor()
        self.alpha = 0.5
        
        //Add the label to the view
        self.addSubview(self.lessonLabel)
        self.lessonLabel.translatesAutoresizingMaskIntoConstraints = false

        //Add the number label
        self.addSubview(self.answerNumberLabel)
        self.answerNumberLabel.translatesAutoresizingMaskIntoConstraints = false

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLessonText(text:String) {
        
        self.lessonLabel.text = text

        //Set properties for the label and constraints
        self.lessonLabel.numberOfLines = 0
        self.lessonLabel.textColor = UIColor.whiteColor()
        self.lessonLabel.textAlignment = NSTextAlignment.Center
        self.lessonLabel.adjustsFontSizeToFitWidth = true
        
        //Set constraints
        let leftMarginConstraint = NSLayoutConstraint(item: self.lessonLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 60)
        
        let rightMarginConstraint = NSLayoutConstraint(item: self.lessonLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: -20)
        
        let topMarginConstraint = NSLayoutConstraint(item: self.lessonLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 5)
        
        let bottomMarginConstraint = NSLayoutConstraint(item: self.lessonLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -5)
        
        self.addConstraints([leftMarginConstraint, rightMarginConstraint, topMarginConstraint, bottomMarginConstraint])
        
        
    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
