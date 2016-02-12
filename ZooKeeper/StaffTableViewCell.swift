//
//  StaffTableViewCell.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/11/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit

class StaffTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageViewStaff: UIImageView!
    @IBOutlet weak var topLabelStaff: UILabel!
    @IBOutlet weak var bottomLabelStaff: UILabel!
    
    var staff: Staff?
    
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
        if let staff = staff {
            topLabelStaff.text = staff.name
            bottomLabelStaff.text = staff.report()
            
            if let _ = staff.photo {
                iconImageViewStaff.image = staff.photo
            } else {
                iconImageViewStaff.image = staff.image()
            }
        }
    }
}
