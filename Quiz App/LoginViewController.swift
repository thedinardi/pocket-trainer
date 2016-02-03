//
//  LoginViewController.swift
//  Quiz App
//
//  Created by Edit Station 3 on 12/8/15.
//  Copyright © 2015 Ric Murray Studio. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    
    @IBOutlet weak var forgotUserButton: UIButton!
    @IBOutlet weak var forgotPassButton: UIButton!

    @IBOutlet weak var registerButton: UIButton!

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.usernameField.delegate = self
        self.passwordField.delegate = self
        
        
        self.forgotUserButton.titleLabel!.textAlignment = NSTextAlignment.Left
        self.forgotPassButton.titleLabel!.textAlignment = NSTextAlignment.Left
        self.registerButton.titleLabel!.textAlignment = NSTextAlignment.Left

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //Dismiss keyboard
        self.usernameField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
    }
    
    //TextField delegate methods
    func textDoneEditing(textField: UITextField) {
        
        //When user has finished editing the texfield
        
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        //Dismiss keyboard with return key
        self.dismissKeyboard()
        self.usernameField.endEditing(true)
        
        return true
    }
    
    
    func dismissKeyboard() {
        
        //Dismiss
        self.usernameField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }

}
