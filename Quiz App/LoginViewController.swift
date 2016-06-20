//
//  LoginViewController.swift
//  Quiz App
//
//  Created by Edit Station 3 on 12/8/15.
//  Copyright © 2015 Ric Murray Studio. All rights reserved.
//

import UIKit
import Parse

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
        forgotPassButton.titleLabel!.adjustsFontSizeToFitWidth = true
        registerButton.titleLabel!.adjustsFontSizeToFitWidth = true
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
    

    @IBAction func registerButtonTapped(sender: AnyObject) {
        
        self.performSegueWithIdentifier("registerSegue", sender: nil)
    }
    
    @IBAction func signinButtonTapped(sender: AnyObject) {
        
        let userEmail = usernameField.text!;
        let userPassword = passwordField.text!;
        
        PFUser.logInWithUsernameInBackground(userEmail, password: userPassword) { (user, error) in
            if error == nil {
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                print("Sign in failed")
            }
        }
        
        
        
        //displayMyAlertMessage("Email or Password have been entered incorrectly.")
    }
    
    func displayMyAlertMessage(userMessage:String) {
        
        let myAlert = UIAlertController(title: "", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }

}
