//
//  DetailViewController.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/4/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var legsTextField: UITextField!
    @IBOutlet weak var isMaleSwitch: UISwitch!

    var detailItem: Animal? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let animal = self.detailItem {
            nameTextField?.text = animal.name
            colorTextField?.text = animal.color
            legsTextField?.text = "\(animal.legCount ?? 0)"
            isMaleSwitch?.on = animal.isMale
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

