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
    @IBOutlet weak var cameraImage: UIImageView!
    
    
    //    var animal: Animal? {
    //        didSet {
    //            nameTextField.text = animal.name
    //
    //            // Customize for Animal View
    //        }
    //    }
    //
    //    var staff: Staff? {
    //        didSet {
    //            if staff != nil {
    //
    //            }
    //
    //            // Custom for Staff View
    //        }
    //    }
    
    // MARK: -
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
    
    // MARK: Actions
    @IBAction func controlChanged(sender: AnyObject) {
        
    }
    @IBAction func cameraTouched(sender: AnyObject) {
        guard let animal = detailItem as? Animal else {return}
        
        if animal.photo == nil {
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
        cameraImage?.image = animal.photo ?? UIImage(named: "camera")
    }
}

extension AnimalViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if let animal = self.detailItem as? Animal {
                animal.photo = image
                cameraImage.image = image
            }
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
