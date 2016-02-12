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
    
    var animal: Animal?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureView()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureView() {
        if let animal = animal {
            topLabel.text = animal.name
            bottomLabel.text = animal.report()
            
            if let _ = animal.photo {
                iconImageView.image = animal.photo
            } else {
                iconImageView.image = animal.image()
            }
        }
    }
}
