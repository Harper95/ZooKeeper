//
//  ImageGalleryViewController.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/17/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit

class ImageGalleryViewController: DetailViewController, UICollectionViewDataSource, UICollectionViewDelegate {
	
	var zoo: Zoo!
	
    @IBOutlet weak var imageColletionView: UICollectionView!
    
    private static let storyboard = UIStoryboard(name: "Modals", bundle: nil)
    
    static func instance() -> ImageGalleryViewController {
        return storyboard.instantiateViewControllerWithIdentifier("ImageGalleryViewController") as! ImageGalleryViewController
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
			if let animal = self.detailItem as? Animal {
				cell.animalLabel.text = animal.name
			// cell.animalImage.image
			}
			return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("StaffCell", forIndexPath: indexPath)
			return cell
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageColletionView.registerNib(UINib(nibName: "StaffCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StaffCell")
		
		zoo = ZooData.sharedInstance.zoo
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "GalleryHeader", forIndexPath: indexPath) as! GalleryHeaderCollectionReusableView
        header.nameLabel.text = indexPath.section == animalKey ? "Animals" : "Staff"
        return header
    }
	
	/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		
    }
	*/
	
    @IBAction func dismissTouched(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
