//
//  LoginViewController.swift
//  Facebook
//
//  Created by Vishay Nihalani on 2/10/16.
//  Copyright © 2016 Vishay Nihalani. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var fieldParentView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var labelParentView: UIView!
    
    var initialY: CGFloat!
    var offset: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        activityIndicatorView.hidden = true
        
        initialY = fieldParentView.frame.origin.y
        offset = -50
        
        loginButton.enabled = false
    }
    
    override func viewDidAppear(animated: Bool) {
        
        loginButton.enabled = false
    }
    
    func keyboardWillShow(notification: NSNotification!) {

        UIView.animateWithDuration(0.3, animations: {
        
            self.fieldParentView.frame.origin.y = self.initialY + self.offset
        })
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        
        UIView.animateWithDuration(0.3, animations: {
            
            self.fieldParentView.frame.origin.y = self.initialY
        })
    }
    
    @IBAction func onTapLoginView(sender: AnyObject) {
        
        view.endEditing(true)
    }

    @IBAction func didLoginButton(sender: AnyObject) {
    
        activityIndicatorView.startAnimating()
        loginButton.selected = true
        
        if emailTextField.text == "a" && passwordTextField.text == "a" {
                
            delay(2, closure: { () -> () in
            
                NSUserDefaults.standardUserDefaults().setObject("user0", forKey: "user")
                
                self.activityIndicatorView.stopAnimating()
                self.loginButton.selected = false
                    
                self.performSegueWithIdentifier("login", sender: self)
            })
        } else if emailTextField.text == "b" && passwordTextField.text == "b" {
            
            delay(2, closure: { () -> () in
                
                NSUserDefaults.standardUserDefaults().setObject("user1", forKey: "user")
                
                self.activityIndicatorView.stopAnimating()
                self.loginButton.selected = false
                
                self.performSegueWithIdentifier("login", sender: self)
            })
        } else {
            
            delay(2, closure: { () -> () in
                
                self.activityIndicatorView.stopAnimating()
                self.loginButton.selected = false
                
                let alertController = UIAlertController(title: "Try again", message: "Your email or password was incorrect.", preferredStyle: .Alert)
                
                let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in

                }
                
                alertController.addAction(okAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            })
        }
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
    
        if (emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty) {
            
            loginButton.enabled = false
        } else {
            
            loginButton.enabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
