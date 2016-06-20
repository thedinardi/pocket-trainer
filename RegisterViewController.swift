//
//  RegisterViewController.swift
//  Quiz App
//
//  Created by AE Tower on 6/2/16.
//  Copyright © 2016 Ric Murray Studio. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var haveAccountButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        haveAccountButton.titleLabel!.adjustsFontSizeToFitWidth = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //Dismiss keyboard
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.confirmTextField.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
    }
    
    //TextField delegate methods
    func textDoneEditing(textField: UITextField) {
        
        //When user has finished editing the texfield
        
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        //Dismiss keyboard with return key
        self.dismissKeyboard()
        self.emailTextField.endEditing(true)
        
        return true
    }
    
    
    func dismissKeyboard() {
        
        //Dismiss
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.confirmTextField.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
        
    }
    
    
    @IBAction func registerButtonTapped(sender: AnyObject) {
        
        let userEmail = emailTextField.text;
        let userPassword = passwordTextField.text;
        let userConfirmPassword = confirmTextField.text;
        let userName = nameTextField.text;
        
        //Check for empty fields
        
        if (userEmail!.isEmpty || userPassword!.isEmpty || userConfirmPassword!.isEmpty) {
            
            
            //Display alert message
            
            displayMyAlertMessage("All fields are required");
            
            return
            
        }
        
        
        //Check if password match
        if (userPassword != userConfirmPassword) {
            
            //Display alert
            displayMyAlertMessage("Passwords do not match")
            
        }
        
        //Store data
        NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail");
        NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey: "userPassword");
        NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "userName");
        NSUserDefaults.standardUserDefaults().synchronize()
        
        
        
        
        //Display alert message with confirmation
        
        let myAlert = UIAlertController(title: "Congratulations", message: "Registration is successful.  Thank You!", preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
        
        
    }
    
    func displayMyAlertMessage(userMessage:String) {
        
        let myAlert = UIAlertController(title: "", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    @IBAction func haveloginButtonTapped(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
