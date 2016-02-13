//
//  FeedViewController.swift
//  Facebook
//
//  Created by Vishay Nihalani on 1/31/16.
//  Copyright © 2016 Vishay Nihalani. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var feedScrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    var homeFeed: UIImage!
    var emptyFeed: UIImage!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var infiniteActivityIndicator: UIActivityIndicatorView!
    var numberOfImageViews: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        feedScrollView.delegate = self
        
        infiniteActivityIndicator.center.x = (feedImageView.frame.size.width - infiniteActivityIndicator.frame.size.width) / 2
        infiniteActivityIndicator.center.y = feedImageView.frame.size.height + 20
        feedScrollView.contentInset.bottom = 130
        
        activityIndicator.hidden = false
    
        feedScrollView.contentSize = feedImageView.image!.size
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        feedScrollView.insertSubview(refreshControl, atIndex: 0)
        
        homeFeed = UIImage(named: "home_feed")
        emptyFeed = UIImage(named: "empty_feed")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        activityIndicator.startAnimating()
        feedImageView.hidden = true
        feedScrollView.delegate = self
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let user = defaults.objectForKey("user") as! String
        
        if user == "user0" {
            
            feedImageView.image = emptyFeed
            feedImageView.frame.size = emptyFeed.size
            
        } else {
            
            feedImageView.image = homeFeed
            feedImageView.frame.size = homeFeed.size
        }
        
        feedScrollView.contentSize = feedImageView.frame.size
    }
    
    override func viewDidAppear(animated: Bool) {
        
        delay(2, closure: { () -> () in

            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidden = true
            self.feedImageView.hidden = false
        })
    }
    
    func onRefresh() {

        delay(2, closure: {
            self.refreshControl.endRefreshing()
        })
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        print("Scrolling stopped")
        
        // Remember that contentOffset is set from the top of the screen.
        if feedScrollView.contentOffset.y + feedScrollView.frame.size.height >= feedScrollView.contentSize.height {
            print("...at the bottom")
            
            delay(1, closure: { () -> () in
                
                let newFrame = self.feedImageView.frame
                let newImageView = UIImageView(frame: newFrame)
                let newImage = UIImage(named: "home_feed")
                
                newImageView.image = newImage
                newImageView.frame.origin.y = self.feedImageView.frame.origin.y + self.numberOfImageViews * self.feedImageView.frame.size.height
                self.feedScrollView.addSubview(newImageView)
                
                self.infiniteActivityIndicator.center.y = self.feedImageView.image!.size.height + 20 + self.numberOfImageViews * newImageView.frame.size.height
                
                self.feedScrollView.contentSize = CGSize(width: self.feedImageView.frame.size.width, height: self.feedImageView.image!.size.height + self.numberOfImageViews * newImageView.frame.size.height)
                self.numberOfImageViews += 1
            })
        }
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
