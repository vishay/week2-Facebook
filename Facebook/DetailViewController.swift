//
//  DetailViewController.swift
//  Facebook
//
//  Created by Vishay Nihalani on 1/31/16.
//  Copyright © 2016 Vishay Nihalani. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var parentView: UIView!

    // define variables for the commentImageView slide
    var initialY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        detailScrollView.contentSize = CGSize(width: 320, height: 1000)
        
        // store initial position of the commentImageView
        initialY = self.parentView.frame.origin.y
    }

    @IBAction func didTouchUpInsideLikeButton(sender: UIButton) {
        
        sender.selected = !sender.selected
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        
        // hide the tab bar
        self.tabBarController!.tabBar.hidden = true
        
        // move the commentImageView up
        let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let overlap = self.tabBarController!.tabBar.frame.height
        let offset = frame.height
        
        parentView.frame.origin.y = initialY - offset + overlap
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        
        // move the commentImageView down
        parentView.frame.origin.y = initialY
        
        // show the tab bar
        self.tabBarController!.tabBar.hidden = false
    }
    
    @IBAction func onTap(sender: AnyObject) {

        view.endEditing(true)
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
