//
//  MasterViewController.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/4/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit
import SwiftyJSON

// Declares the index for each Row
let animalKey: Int = 0
let  staffKey: Int = 1

// The Table view screen
class ZooTableViewController: UITableViewController {
	
	// Why set it to nil?, won't it default to nil
    var detailViewController: DetailViewController? = nil
	// Sets the zoo variable as a type of the Zoo class
    var zoo: Zoo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
		// Sets addButton to a button that has a plus button image and calls the insertNewObject function
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
		// Sets the top right button to the addButton
        self.navigationItem.rightBarButtonItem = addButton
		// if self.splitViewController != nil
        if let split = self.splitViewController {
            let controllers = split.viewControllers
			//
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
		// Sets the row height to 85
        tableView.rowHeight = 85
		// zoo = zooFromJsonFileNamed(dataNameFile) || an empty zoo
        zoo = ZooData.sharedInstance.zoo
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
		// updates the tableview to show new data
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
		let alertController = UIAlertController(
			title: nil,
			message: "Would you like to create an new animal or staff member?",
			preferredStyle: .Alert
		)
		
		let animalAction = UIAlertAction(
			title: "Animal", style: .Default) { (action) in
				let indexPath = NSIndexPath(forRow: 0, inSection: animalKey)
				self.zoo.animals.insert(Animal(type: "Species", name: "Name", color: "Color", isMale: true), atIndex: animalKey)
				self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
		}
		
		let staffAction = UIAlertAction(
			title: "Staff", style: .Default) { (action) in
				let indexPath = NSIndexPath(forRow: 0, inSection: staffKey)
				self.zoo.staff.insert(Staff(type: "Occupation", name: "Name", isMale: true), atIndex: staffKey)
				self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
		}
		
		let cancelAction = UIAlertAction(
			title: "Cancel", style: .Default) { (action) in
			
		}
	
		alertController.addAction(animalAction)
		alertController.addAction(staffAction)
		alertController.addAction(cancelAction)
		
		presentViewController(alertController, animated: true, completion: nil)
	}
	
	
    // MARK: - Segues
	// Notifies the view controller that a segue is about to be performed
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		// if te user selected an animal
        if segue.identifier == "AnimalDetail" {
			// indexPath is set to the Row that the user seleceted
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
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        if let viewController = storyboard!.instantiateViewControllerWithIdentifier("StaffViewController") as? StaffViewController {
//            let staff: Staff = data[staffKey]![indexPath.row] as! Staff
//            viewController.staff = staff
//            navigationController!.pushViewController(viewController, animated: true)
//        }
//    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

