//
//  AnswerButtonView.swift
//  Quiz App
//
//  Created by AE Tower on 11/10/15.
//  Copyright © 2015 Ric Murray Studio. All rights reserved.
//

import UIKit

class AnswerButtonView: UIView {

    let answerLabel = UILabel()
    let answerNumberLabel = UILabel()
    let backgroundImage = UIImageView()

    override init(frame: CGRect) {
        super.init(frame:frame)
        
        //Set background and alpha
        
        self.alpha = 0.9
        self.backgroundColor = UIColor(red: 13/255, green: 170/255, blue:234/255, alpha: 1)
 
        //Add the label to the view
        self.addSubview(self.answerLabel)
        self.answerLabel.translatesAutoresizingMaskIntoConstraints = false
 
        //Add the number label
        self.addSubview(self.answerNumberLabel)
        self.answerNumberLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setAnswerText(text:String) {
        
        self.answerLabel.text = text
        
        //Set properties for the label and constraints
        self.answerLabel.numberOfLines = 0
        self.answerLabel.textColor = UIColor.whiteColor()
        self.answerLabel.textAlignment = NSTextAlignment.Center
        self.answerLabel.adjustsFontSizeToFitWidth = true
        
        //iPad font
        if (UI_USER_INTERFACE_IDIOM() == .Pad) {
            self.answerLabel.font = UIFont.systemFontOfSize(40)
            self.answerNumberLabel.font = UIFont.systemFontOfSize(40)
        }

        //Set constraints
        let leftMarginConstraint = NSLayoutConstraint(item: self.answerLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 40)
        
        let rightMarginConstraint = NSLayoutConstraint(item: self.answerLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: -20)
        
        let topMarginConstraint = NSLayoutConstraint(item: self.answerLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 5)
        
        let bottomMarginConstraint = NSLayoutConstraint(item: self.answerLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -5)
        
        self.addConstraints([leftMarginConstraint, rightMarginConstraint, topMarginConstraint, bottomMarginConstraint])
    }
    
    func setAnswerNumber(answernumber:Int) {
        self.answerNumberLabel.text = String(answernumber)
        
        //Set properties for label and constraints
        self.answerNumberLabel.textColor = UIColor.whiteColor()
        self.answerNumberLabel.textAlignment = NSTextAlignment.Center
        self.answerNumberLabel.backgroundColor = UIColor.blackColor()
        self.answerNumberLabel.alpha = 0.5
        self.answerNumberLabel.font = UIFont.boldSystemFontOfSize(14)
        
        //iPad font
        if (UI_USER_INTERFACE_IDIOM() == .Pad) {
            self.answerNumberLabel.font = UIFont.systemFontOfSize(40)
        }
        
        //Set constraints
        let widthConstraint:NSLayoutConstraint = NSLayoutConstraint(item: self.answerNumberLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 40)
        
        self.answerNumberLabel.addConstraint(widthConstraint)
        
        let leftMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: self.answerNumberLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
        
        let topMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: self.answerNumberLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        
        let bottomMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: self.answerNumberLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        
        self.addConstraints([leftMarginConstraint, topMarginConstraint, bottomMarginConstraint])
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
