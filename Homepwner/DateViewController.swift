//
//  DateViewController.swift
//  Homepwner
//
//  Created by Tianyi Ben on 2016-07-10.
//  Copyright © 2016 Tianyi Ben. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
	var item: Item!

	@IBOutlet var datePicker: UIDatePicker!

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)

		self.datePicker.date = self.item.dateCreated
	}

	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)

		self.item.dateCreated = self.datePicker.date
	}
}
