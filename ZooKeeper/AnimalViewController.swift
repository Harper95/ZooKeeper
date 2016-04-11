//
//  AnimalViewController.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/10/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit
import Firebase

class AnimalViewController: DetailViewController {
    
    // MARK: Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var maleFemaleSwitch: UISegmentedControl!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    @IBOutlet weak var photoImageView: UIImageView!
	
	var animalKey: String?
	
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		if let key = animalKey where detailItem == nil {
			let ref = ZooData.sharedInstance.rootRef.childByAppendingPath("aniamls/\(key)")
			ref.observeEventType(.Value, withBlock: { (snapshot) -> Void in
				self.detailItem = Animal(snapshot: snapshot)
				self.configureView()
			})
		}
	}
	
    // MARK: Actions
    @IBAction func controlChanged(sender: AnyObject) {
		guard let animal = detailItem as? Animal else { return }
		
		animal.name = nameTextField.text!
		animal.color = colorTextField.text!
		animal.currentWeight = Float(weightTextField.text!)
		animal.isMale = maleFemaleSwitch.selectedSegmentIndex == 0 ? true : false
		animal.birthday = birthdayDatePicker.date
		animal.updateInFB()
    }
	
    @IBAction func cameraTouched(sender: AnyObject) {
        guard let animal = detailItem as? Animal else { return }
        
        if !animal.hasCustomImage() {
            CTHPresentImageCapture(self, title: "Add Image", message: "Please choose a source")
        } else {
            CTHAlertFor(self, title: "Replace photo", message: "Are you sure you want to replace this image", okCallback: { () -> Void in
                CTHPresentImageCapture(self, title: "Add Image", message: "Please choose a source")
                }) {									// Trailing Closure
                    print("User Cancelled")
            }
        }
    }
    
    // MARK: -
    override func configureView() {
        guard let animal = self.detailItem as? Animal where nameTextField != nil else { return }
		
        nameTextField?.text = animal.name
        colorTextField?.text = animal.color
        if let weight = animal.currentWeight {
            weightTextField?.text = NSString(format: "%0.2f", weight) as String
        } else {
            weightTextField?.text = ""
        }
        maleFemaleSwitch?.selectedSegmentIndex = animal.isMale ? 0 : 1
        photoImageView?.image = animal.getImage() ?? UIImage(named: "camera")
		if let birthday = animal.birthday {
			birthdayDatePicker.date = birthday
		}
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
