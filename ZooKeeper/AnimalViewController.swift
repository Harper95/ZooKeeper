//
//  AnimalViewController.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/10/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit

class AnimalViewController: DetailViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var maleFemaleSwitch: UISegmentedControl!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    @IBAction func controlChanged(sender: AnyObject) {
        
    }
    
    override func configureView() {
        if let animal = self.detailItem as? Animal{
            nameTextField?.text = animal.name
            colorTextField?.text = animal.color
            maleFemaleSwitch?.selectedSegmentIndex = animal.isMale ? 0 : 1
        }
    }

}
