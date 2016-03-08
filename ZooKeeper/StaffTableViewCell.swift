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
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	func configureViewForStaff(staff: Staff) {
		topLabelStaff.text = staff.name
		bottomLabelStaff.text = staff.report()
		iconImageViewStaff.image = staff.getImage()
	}
}

