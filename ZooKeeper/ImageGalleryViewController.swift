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
    
    private static let storyboard = UIStoryboard(name: "Modals", bundle: nil)
    
    static func instance() -> ImageGalleryViewController {
        return storyboard.instantiateViewControllerWithIdentifier("ImageGalleryViewController") as! ImageGalleryViewController
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AnimalCell", forIndexPath: indexPath) as! AnimalCollectionViewCell
        cell.nameLabel.text = "name"
        return cell
    }
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
    
    @IBAction func dismissTouched(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
