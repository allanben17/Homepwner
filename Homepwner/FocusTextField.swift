//
//  FocusTextField.swift
//  Homepwner
//
//  Created by Tianyi Ben on 2016-07-03.
//  Copyright © 2016 Tianyi Ben. All rights reserved.
//

import UIKit

class FocusTextField: UITextField {
	override func becomeFirstResponder() -> Bool {
		self.borderStyle = .Bezel

		return super.becomeFirstResponder()
	}

	override func resignFirstResponder() -> Bool {
		self.borderStyle = .RoundedRect

		return super.resignFirstResponder()
	}
}
