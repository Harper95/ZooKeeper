//
//  AnimalViewController.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/10/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit

class AnimalViewController: DetailViewController {
    
    // MARK: Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var maleFemaleSwitch: UISegmentedControl!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    @IBOutlet weak var photoImageView: UIImageView!
	
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func controlChanged(sender: AnyObject) {
		guard let animal = detailItem as? Animal else { return }
		
		animal.name = nameTextField.text!
		animal.color = colorTextField.text!
		animal.currentWeight = Float(weightTextField.text!)
		animal.isMale = maleFemaleSwitch.selectedSegmentIndex == 0 ? true : false
		animal.birthday = birthdayDatePicker.date
		ZooData.sharedInstance.saveZoo()
    }
    @IBAction func cameraTouched(sender: AnyObject) {
        guard let animal = detailItem as? Animal else {return}
        
        if animal.loadImage() == nil {
            CTHPresentImageCapture(self, title: "Add Image", message: "Please choose a source")
        } else {
            CTHAlertFor(self, title: "Replace photo", message: "Are you sure you want to replace this image", okCallback: { () -> Void in
                CTHPresentImageCapture(self, title: "Add Image", message: "Please choose a source")
                }) { () -> Void in                      // Trailing Closure
                    print("User Cancelled")
            }
        }
    }
    
    // MARK: -
    override func configureView() {
        guard let animal = self.detailItem as? Animal where nameTextField != nil else {return}
        
        nameTextField?.text = animal.name
        colorTextField?.text = animal.color
        if let weight = animal.currentWeight {
            weightTextField?.text = NSString(format: "%0.2", weight) as String
        } else {
            weightTextField?.text = "unknown"
        }
        maleFemaleSwitch?.selectedSegmentIndex = animal.isMale ? 0 : 1
        photoImageView?.image = animal.loadImage() ?? UIImage(named: "camera")
		ZooData.sharedInstance.saveZoo()
    }
}

extension AnimalViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if let animal = self.detailItem as? Animal {
                photoImageView.image = image
				animal.saveImage(image)
            }
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
