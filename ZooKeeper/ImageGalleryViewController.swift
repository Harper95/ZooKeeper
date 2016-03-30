//
//  ImageGalleryViewController.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/17/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit
import Firebase

struct AnimalImage {
	var key: String
	var name: String
	var imageString: String
}

struct StaffImage {
	var key: String
	var name: String
	var imageString: String
}

class ImageGalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
	
    @IBOutlet weak var imageColletionView: UICollectionView!
	
	var detailViewController: DetailViewController? = nil
	var animalImages = [AnimalImage]()
	var staffImages = [StaffImage]()
	var zoo: Zoo!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
		self.navigationItem.rightBarButtonItem = addButton
		
		if let split = self.splitViewController {
			let controllers = split.viewControllers
			
			self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
		}
		zoo = Zoo(animals: nil, staff: nil)
    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		let animalAvatarsRef = ZooData.sharedInstance.animalAvatarRef
		animalAvatarsRef.observeEventType(.Value, withBlock: { (snapshot: FDataSnapshot!) in
			self.animalImages.removeAll()
			for item in snapshot.children {
				guard let item = item as? FDataSnapshot,
					let name = item.value["name"] as? String,
					let imageString = item.value["imageString"] as? String else { continue }
				self.animalImages.append(AnimalImage(key: item.key, name: name, imageString: imageString))
			}
			self.imageColletionView.reloadData()
		})
		
		let staffAvatarsRef = ZooData.sharedInstance.staffAvatarRef
		staffAvatarsRef.observeEventType(.Value, withBlock: { (snapshot: FDataSnapshot!) in
			self.staffImages.removeAll()
			for item in snapshot.children {
				guard let item = item as? FDataSnapshot,
					let name = item.value["name"] as? String,
					let imageString = item.value["imageString"] as? String else { continue }
				self.staffImages.append(StaffImage(key: item.key, name: name, imageString: imageString))
		}
		self.imageColletionView.reloadData()
	})
	}
	
	func insertNewObject(sender: AnyObject) {
		let alertController = UIAlertController(
			title: nil,
			message: "Would you like to create a new animal or staff member?",
			preferredStyle: .Alert
		)
		
		let animalAction = UIAlertAction(title: "Animal", style: .Default) { (action) in
			let indexPath = NSIndexPath(forRow: 0, inSection: animalSection)
			self.zoo.animals.insert(Animal(type: "Species", name: "Name", color: "Color", isMale: true), atIndex: 0)
			self.imageColletionView.insertItemsAtIndexPaths([indexPath])
		}
		
		let staffAction = UIAlertAction(title: "Staff", style: .Default) { (action) in
			let indexPath = NSIndexPath(forRow: 0, inSection: animalSection)
			self.zoo.staff.insert(Staff(type: "Occupation", name: "Name", isMale: true), atIndex: 0)
			self.imageColletionView.insertItemsAtIndexPaths([indexPath])
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .Destructive, handler: nil)
		
		alertController.addAction(animalAction)
		alertController.addAction(staffAction)
		alertController.addAction(cancelAction)
		
		presentViewController(alertController, animated: true, completion: nil)
	}
	
	// MARK: - Collection View
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
   }
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch section {
		case animalSection:
			return zoo.animals.count
		case staffSection:
			return zoo.staff.count
		default:
			return 0
		}
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		if indexPath.section == animalSection {
			let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AnimalCell", forIndexPath: indexPath) as! AnimalCollectionViewCell
			
			let animalImage = animalImages[indexPath.row]
			cell.animalLabel.text = animalImage.name
			if let data = NSData(base64EncodedString: animalImage.imageString, options: .IgnoreUnknownCharacters),
				let image = UIImage(data: data) {
					cell.animalImage.image = image
			}
			
			return cell
		} else {
			let cell = collectionView.dequeueReusableCellWithReuseIdentifier("StaffCell", forIndexPath: indexPath) as! StaffCollectionViewCell
			
			let staffImage = staffImages[indexPath.row]
			cell.staffLabel.text = staffImage.name
			if let data = NSData(base64EncodedString: staffImage.imageString, options: .IgnoreUnknownCharacters),
				let image = UIImage(data: data) {
					cell.staffImage.image = image
			}
			
			return cell
		}
	}
	
	func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
		let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "GalleryHeader", forIndexPath: indexPath) as! GalleryHeaderCollectionReusableView
		header.nameLabel.text = indexPath.section == animalSection ? "Animals" : "Staff"
		return header
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "AnimalDetail" {
			if let indexPath = self.imageColletionView.indexPathsForSelectedItems()!.first {
				let object = zoo.animals[indexPath.row]
				let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
				controller.detailItem = object
				controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
				controller.navigationItem.leftItemsSupplementBackButton = true
			}
		} else if segue.identifier == "StaffDetail" {
			if let indexPath = self.imageColletionView.indexPathsForSelectedItems()!.first {
				let object = zoo.staff[indexPath.row]
				let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
				controller.detailItem = object
				controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
				controller.navigationItem.leftItemsSupplementBackButton = true
			}
		}
		}
	
    @IBAction func dismissTouched(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
