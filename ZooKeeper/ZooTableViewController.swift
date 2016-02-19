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
        // Do any additional setup after loading the view, typically from a nib.
        // self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        tableView.rowHeight = 85
        zoo = ZooData.sharedInstance.zoo
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        //        objects.insert(NSDate(), atIndex: 0)
        //        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        //        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
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
        if indexPath.section == 0 {
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
            if indexPath.section == staffKey{
                zoo.animals.removeAtIndex(indexPath.row)
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

