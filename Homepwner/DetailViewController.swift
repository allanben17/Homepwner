//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Tianyi Ben on 2016-07-02.
//  Copyright © 2016 Tianyi Ben. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	
	@IBOutlet var nameField: UITextField!
	@IBOutlet var serialNumberField: UITextField!
	@IBOutlet var valueField: UITextField!
	@IBOutlet var dateLabel: UILabel!
	@IBOutlet var imageView: UIImageView!

	var item: Item! {
		didSet {
			self.navigationItem.title = self.item.name
		}
	}
	var imageStore: ImageStore!

	let numberFormatter: NSNumberFormatter = {
		let formatter = NSNumberFormatter()
		formatter.numberStyle = .DecimalStyle
		formatter.minimumFractionDigits = 2
		formatter.maximumFractionDigits = 2
		return formatter
	}()

	let dateFormatter: NSDateFormatter = {
		let formatter = NSDateFormatter()
		formatter.dateStyle = .MediumStyle
		formatter.timeStyle = .NoStyle
		return formatter
	}()

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)

		self.nameField.text = self.item.name
		self.serialNumberField.text = self.item.serialNumber
		self.valueField.text = self.numberFormatter.stringFromNumber(self.item.valueInDollars)
		self.dateLabel.text = self.dateFormatter.stringFromDate(self.item.dateCreated)

		// Get the item key
		let key = self.item.itemKey

		// If there is an associated image with the item
		// display it on the image view
		let imageToDisplay = self.imageStore.imageForKey(key)
		imageView.image = imageToDisplay
	}

	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)

		// Clear first responder
		self.view.endEditing(true)

		// "Save" changes to item
		self.item.name = self.nameField.text ?? ""
		self.item.serialNumber = self.serialNumberField.text

		if let valueText = self.valueField.text, value = self.numberFormatter.numberFromString(valueText) {
			self.item.valueInDollars = value.integerValue
		} else {
			self.item.valueInDollars = 0
		}
	}

	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}

	@IBAction func backgroundTapped(sender: UITapGestureRecognizer) {
		self.view.endEditing(true)
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "ShowDate" {
			let dateViewController = segue.destinationViewController as! DateViewController
			dateViewController.item = item
		}
	}

	@IBAction func takePicture(sender: UIBarButtonItem) {

		let imagePicker = UIImagePickerController()

		// If the device has a camera, take a picture; otherwise,
		// just pick from photo library
		if UIImagePickerController.isSourceTypeAvailable(.Camera) {
			imagePicker.sourceType = .Camera
		} else {
			imagePicker.sourceType = .PhotoLibrary
		}

		imagePicker.delegate = self

		// Place image picker on the screen
		self.presentViewController(imagePicker, animated: true, completion: nil)
	}

	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {

		// Get picked image from info dictionary
		let image = info[UIImagePickerControllerOriginalImage] as! UIImage!

		// Store the image in the ImageStore for the item's key
		self.imageStore.setImage(image, forKey: self.item.itemKey)

		// Put that image on the screen in the image view
		self.imageView.image = image

		// Take image picker off the screen -
		// you must call this dismiss method
		self.dismissViewControllerAnimated(true, completion: nil)
	}
}
