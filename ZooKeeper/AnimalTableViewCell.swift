//
//  AnimalTableViewCell.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/10/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit

class AnimalTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
	}

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func configureViewForAnimal(animal: Animal) {
		topLabel.text = animal.name
		bottomLabel.text = animal.report()
		iconImageView.image = animal.getImage()
    }
}
