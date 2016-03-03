//
//  MasterViewController.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/4/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit
import SwiftyJSON

let animalKey: Int = 0
let  staffKey: Int = 1

class ZooTableViewController: UITableViewController {
	
    var detailViewController: DetailViewController? = nil
    var zoo: Zoo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
		
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
		
        tableView.rowHeight = 85
        zoo = ZooData.sharedInstance.zoo
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "dataUpdated:", name: ZooDataNotifications.Updated.rawValue, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
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
				let indexPath = NSIndexPath(forRow: 0, inSection: animalKey)
				self.zoo.animals.insert(Animal(type: "Species", name: "Name", color: "Color", isMale: true), atIndex: 0)
				self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
		}
		
		let staffAction = UIAlertAction(
			title: "Staff", style: .Default) { (action) in
				let indexPath = NSIndexPath(forRow: 0, inSection: staffKey)
				self.zoo.staff.insert(Staff(type: "Occupation", name: "Name", isMale: true), atIndex: 0)
				self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
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
        case animalKey:
            return zoo.animals.count
        case staffKey:
            return zoo.staff.count
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == animalKey {
            let cell = tableView.dequeueReusableCellWithIdentifier("AnimalCell", forIndexPath: indexPath) as! AnimalTableViewCell
            let animal: Animal = zoo.animals[indexPath.row]
            
            cell.animal = animal
            cell.configureView()
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("StaffCell", forIndexPath: indexPath) as! StaffTableViewCell
            let staff: Staff = zoo.staff[indexPath.row]
            
            cell.staff = staff
            cell.configureView()
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if indexPath.section == animalKey {
                zoo.animals.removeAtIndex(indexPath.row)
            }
            if indexPath.section == staffKey {
                zoo.staff.removeAtIndex(indexPath.row)
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
		} 
		ZooData.sharedInstance.saveZoo()
    }
}

