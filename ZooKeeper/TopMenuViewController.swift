//
//  TopMenuViewController.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/17/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit
// Main Page
class TopMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let _ = ZooData.sharedInstance.zoo
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
    
    @IBAction func zooListButtonPressed(sender: UIButton) {
		// When user selects Zoo List the screen switches to ZooTableViewController
        performSegueWithIdentifier("ZooList", sender: self)
    }
    @IBAction func imageGalleryTapped(sender: AnyObject) {
		// presents the ImageGalleryViewController
        let viewController = ImageGalleryViewController.instance()
        presentViewController(viewController, animated: true, completion: nil)
    }
}
