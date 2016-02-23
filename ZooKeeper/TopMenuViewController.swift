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
