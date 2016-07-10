//
//  ItemCell.swift
//  Homepwner
//
//  Created by Tianyi Ben on 2016-07-01.
//  Copyright © 2016 Tianyi Ben. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var serialNumberLabel: UILabel!
	@IBOutlet var valueLabel: UILabel!

	func updateLabels() {
		let bodyFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
		self.nameLabel.font = bodyFont
		self.valueLabel.font = bodyFont

		let caption1Font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
		self.serialNumberLabel.font = caption1Font
	}
}
