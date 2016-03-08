//
//  StaffViewController.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/11/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit

class StaffViewController: DetailViewController {
    
    // MARK: Outlets
    @IBOutlet weak var nameTextFieldStaff: UITextField!
    @IBOutlet weak var weightTextFieldStaff: UITextField!
    @IBOutlet weak var maleFemaleSwitchStaff: UISegmentedControl!
    @IBOutlet weak var birthdayDatePickerStaff: UIDatePicker!
	@IBOutlet weak var photoImageViewStaff: UIImageView!
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//		ZooData.sharedInstance.saveZoo()
    }
    
    // MARK: Actions
    @IBAction func controlChanged(sender: AnyObject) {
		guard let staff = detailItem as? Staff else { return }
		
		staff.name = nameTextFieldStaff.text!
		staff.currentWeight = Float(weightTextFieldStaff.text!)
		staff.isMale = maleFemaleSwitchStaff.selectedSegmentIndex == 0 ? true : false
		staff.birthday = birthdayDatePickerStaff.date
		
//		ZooData.sharedInstance.saveZoo()
    }
    @IBAction func cameraTouched(sender: AnyObject) {
		guard let staff = detailItem as? Staff else { return }
		
		if !staff.hasCustomImage() {
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
		guard let staff = self.detailItem as? Staff where nameTextFieldStaff != nil else { return }

		nameTextFieldStaff?.text = staff.name
		if let weight = staff.currentWeight {
			weightTextFieldStaff?.text = NSString(format: "%0.2f", weight) as String
		} else {
			weightTextFieldStaff?.text = ""
		}
		maleFemaleSwitchStaff?.selectedSegmentIndex = staff.isMale ? 0 : 1
		photoImageViewStaff?.image = staff.getImage() ?? UIImage(named: "camera")
		if let birthday = staff.birthday {
			birthdayDatePickerStaff.date = birthday
		}
//		ZooData.sharedInstance.saveZoo()
    }
}

extension StaffViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if let staff = self.detailItem as? Staff {
				photoImageViewStaff.image = image
				staff.saveImage(image)
			}
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
