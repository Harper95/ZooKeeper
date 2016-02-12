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
        CTHPresentImageCapture(self, title: "Add Image", message: "Please choose a source")
    }
    
    // MARK: -
    override func configureView() {
        if let staff = self.detailItem as? Staff{
            nameTextFieldStaff?.text = staff.name
            maleFemaleSwitchStaff?.selectedSegmentIndex = staff.isMale ? 0 : 1
            
        }
    }
    
}

extension StaffViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            print(image)
            if let staff = self.detailItem as? Staff {
                staff.photo = image
            }
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
