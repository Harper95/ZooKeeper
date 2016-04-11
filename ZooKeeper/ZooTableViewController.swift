//
//  MasterViewController.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/4/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit
import Firebase

let animalSection: Int = 0
let  staffSection: Int = 1

class ZooTableViewController: UITableViewController {
	
	let animalRef = ZooData.sharedInstance.rootRef.childByAppendingPath("animals")
	let staffRef = ZooData.sharedInstance.rootRef.childByAppendingPath("staff")
	
    var detailViewController: DetailViewController? = nil
    var zoo: Zoo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ZooTableViewController.insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
		
        if let split = self.splitViewController {
            let controllers = split.viewControllers
			
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
		
        zoo = Zoo(animals: nil, staff: nil)
		tableView.rowHeight = 85
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ZooTableViewController.dataUpdated(_:)), name: ZooDataNotifications.Updated.rawValue, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
		
		animalRef.observeEventType(.Value, withBlock: { snapshot in
			self.zoo.animals = [Animal]()
			for item in snapshot.children {
				let animal = Animal(snapshot: item as! FDataSnapshot)
				self.zoo.animals.append(animal)
			}
			print("Loaded \(self.zoo.animals.count) animals")
			self.tableView.reloadData()
			
			}) { error in
				print(error.description)
		}
	
		staffRef.observeEventType(.Value, withBlock: { snapshot in
			self.zoo.staff = [Staff]()
			for item in snapshot.children {
				let staff = Staff(snapshot: item as! FDataSnapshot)
				self.zoo.staff.append(staff)
			}
			print("Loaded \(self.zoo.staff.count) staff members")
			self.tableView.reloadData()
			
			}) { error in
				print(error.description)
		}
	}
	
	func dataUpdated(notification: NSNotification) {
		tableView.reloadData()
	}
	
    func insertNewObject(sender: AnyObject) {
		let alertController = UIAlertController(
			title: nil,
			message: "Would you like to create a new animal or staff member?",
			preferredStyle: .Alert
		)
		
		let animalAction = UIAlertAction(
			title: "Animal", style: .Default) { (action) in
				let animal = Animal(type: "Species", name: "Name", color: "Color", isMale: true)
				let animalRefItem = self.animalRef.childByAutoId()
				animalRefItem.setValue(animal.toDictionary())
		}
		
		let staffAction = UIAlertAction(
			title: "Staff", style: .Default) { (action) in
				let staff = Staff(type: "Occupation", name: "Name", isMale: true)
				let staffRefItem = self.staffRef.childByAutoId()
				staffRefItem.setValue(staff.toDictionary())
		}
		
		let cancelAction = UIAlertAction(
			title: "Cancel", style: .Destructive, handler: nil)
				
		alertController.addAction(animalAction)
		alertController.addAction(staffAction)
		alertController.addAction(cancelAction)
		
		presentViewController(alertController, animated: true, completion: nil)
	}
	
	
    // MARK: - Segues

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AnimalDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = zoo.animals[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        } else if segue.identifier == "StaffDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = zoo.staff[indexPath.row]
				let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
				controller.detailItem = object
				controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
				controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
	
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case animalSection:
            return zoo.animals.count
        case staffSection:
            return zoo.staff.count
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == animalSection {
            let cell = tableView.dequeueReusableCellWithIdentifier("AnimalCell", forIndexPath: indexPath) as! AnimalTableViewCell
            let animal: Animal = zoo.animals[indexPath.row]
            
            cell.configureViewForAnimal(animal)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("StaffCell", forIndexPath: indexPath) as! StaffTableViewCell
            let staff: Staff = zoo.staff[indexPath.row]
            
            cell.configureViewForStaff(staff)
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if indexPath.section == animalSection {
                zoo.animals.removeAtIndex(indexPath.row)
            }
            if indexPath.section == staffSection {
                zoo.staff.removeAtIndex(indexPath.row)
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
		} 
    }
}

