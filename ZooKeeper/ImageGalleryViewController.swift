//
//  ImageGalleryViewController.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/17/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit

class ImageGalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
	
    @IBOutlet weak var imageColletionView: UICollectionView!
	
	var detailViewController: DetailViewController? = nil
	var zoo: Zoo!
    
//	private static let storyboard = UIStoryboard(name: "Modals", bundle: nil)
	
//	static func instance() -> ImageGalleryViewController {
//	    return storyboard.instantiateViewControllerWithIdentifier("ImageGalleryViewController") as! ImageGalleryViewController
//	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
		self.navigationItem.rightBarButtonItem = addButton
		
		if let split = self.splitViewController {
			let controllers = split.viewControllers
			
			self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
		}
		zoo = ZooData.sharedInstance.zoo
    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		imageColletionView.reloadData()
	}
	
	func insertNewObject(sender: AnyObject) {
		let alertController = UIAlertController(
			title: nil,
			message: "Would you like to create a new animal or staff member?",
			preferredStyle: .Alert
		)
		
		let animalAction = UIAlertAction(title: "Animal", style: .Default) { (action) in
			let indexPath = NSIndexPath(forRow: 0, inSection: animalKey)
			self.zoo.animals.insert(Animal(type: "Species", name: "Name", color: "Color", isMale: true), atIndex: animalKey)
			self.imageColletionView.insertItemsAtIndexPaths([indexPath])
		}
		
		let staffAction = UIAlertAction(title: "Staff", style: .Default) { (action) in
			let indexPath = NSIndexPath(forRow: 0, inSection: staffKey)
			self.zoo.staff.insert(Staff(type: "Occupation", name: "Name", isMale: true), atIndex: staffKey)
			self.imageColletionView.insertItemsAtIndexPaths([indexPath])
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .Destructive, handler: nil)
		
		alertController.addAction(animalAction)
		alertController.addAction(staffAction)
		alertController.addAction(cancelAction)
		
		presentViewController(alertController, animated: true, completion: nil)
	}
	
	// MARK: - Segues
	
//	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//		if segue.identifier == "AnimalCollectionDetail" {
//			if let indexPath = self.imageColletionView.indexPathsForSelectedItems() {
//				
//			}
//		}
//	}
	
	// MARK: - Collection View
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
   }
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch section {
		case animalKey:
			return zoo.animals.count
		case staffKey:
			return zoo.staff.count
		default:
			return 0
		}
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		if indexPath.section == animalKey {
			let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AnimalCell", forIndexPath: indexPath) as! AnimalCollectionViewCell
			let animal: Animal = zoo.animals[indexPath.section]
			
			cell.animalLabel.text = animal.name
			cell.animalImage.image = animal.loadImage() ?? UIImage(named: "camera")
			
			return cell
		} else {
			let cell = collectionView.dequeueReusableCellWithReuseIdentifier("StaffCell", forIndexPath: indexPath) as! StaffCollectionViewCell
			let staff: Staff = zoo.staff[indexPath.section]
			
			cell.staffLabel.text = staff.name
			
			return cell
		}
	}
	
	func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
		let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "GalleryHeader", forIndexPath: indexPath) as! GalleryHeaderCollectionReusableView
		header.nameLabel.text = indexPath.section == animalKey ? "Animals" : "Staff"
		return header
	}
	
    @IBAction func dismissTouched(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
