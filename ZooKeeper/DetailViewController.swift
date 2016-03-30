//
//  DetailViewController.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/4/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit

// The blank opening View Controller
class DetailViewController: UIViewController {

	var detailItem: AnyObject? {
        didSet {
            configureView()
        }
    }

	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureView()
	}
	
    func configureView() {}
}

