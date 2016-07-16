//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Tianyi Ben on 2016-06-04.
//  Copyright © 2016 Tianyi Ben. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {

	var itemStore: ItemStore!
	var imageStore: ImageStore!

	@IBAction func addNewItem(sender: AnyObject) {
		// Create a new item ad add it to the store
		let newItem = itemStore.createItem()

		// Figure out where that item is in the array
		if let index = itemStore.allItems.indexOf(newItem) {
			let indexPath = NSIndexPath(forRow: index, inSection: 0)

			// Insert this new row into the table
			self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
		}
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemStore.allItems.count + 1
	}

	override func  tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		// Get a new or recycled cell
		let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell

		// Update the labels for the new preferred text size
		cell.updateLabels()

		if indexPath.row == self.tableView(tableView, numberOfRowsInSection: indexPath.section) - 1 {
			cell.nameLabel.text = "No more items!"
			cell.serialNumberLabel.text = nil
			cell.valueLabel.text = nil

			return cell
		}

		// Set the text on the cell with the description of the item
		// that is at the nth index of items, where n = row this cell
		// will appear in on the tableview
		let item = itemStore.allItems[indexPath.row]

		// Configure the cell with the Item
		cell.nameLabel.text = item.name
		cell.serialNumberLabel.text = item.serialNumber
		cell.valueLabel.text = "$\(item.valueInDollars)"
		if item.valueInDollars >= 50 {
			cell.valueLabel.textColor = UIColor.redColor()
		} else {
			cell.valueLabel.textColor = UIColor.greenColor()
		}

		return cell
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.tableView.backgroundView = UIImageView(image: UIImage(named: "tableBack"))

		self.tableView.rowHeight = UITableViewAutomaticDimension
		self.tableView.estimatedRowHeight = 65
	}

	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		// If the table view is asking to commit a delete command...
		if editingStyle == .Delete {
			let item = self.itemStore.allItems[indexPath.row]

			let title = "Delete \(item.name)?"
			let message = "Are you sure you want to delete this item?"

			let ac = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)

			let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
			ac.addAction(cancelAction)

			let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) { action in
				// Remove the item from the store
				self.itemStore.removeItem(item)

				// Remove the item's image from the image store
				self.imageStore.deleteImageForKey(item.itemKey)

				// Also remove that row from the table view with an animation
				self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
			}
			ac.addAction(deleteAction)

			// Present the alert controller
			self.presentViewController(ac, animated: true, completion: nil)
		}
	}

	override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
		// Update the model
		itemStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
	}

	override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
		return "Remove"
	}

	override func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
		if sourceIndexPath.row == self.tableView(tableView, numberOfRowsInSection: sourceIndexPath.section) - 1 {
			return sourceIndexPath
		}

		if proposedDestinationIndexPath.row == self.tableView(tableView, numberOfRowsInSection: proposedDestinationIndexPath.section) - 1 {
			return NSIndexPath(forRow: proposedDestinationIndexPath.row - 1, inSection: proposedDestinationIndexPath.section)
		}

		return proposedDestinationIndexPath
	}

	override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
		if indexPath.row == self.tableView(tableView, numberOfRowsInSection: indexPath.section) - 1 {
			return .None
		}

		return .Delete
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		// If the triggered segue is the "ShowItem" segue
		if segue.identifier == "ShowItem" {

			// Figure out which row was just tapped
			if let row = tableView.indexPathForSelectedRow?.row {

				// Get the item associated with this row and pass it along
				let item = self.itemStore.allItems[row]
				let detailViewController = segue.destinationViewController as! DetailViewController
				detailViewController.item = item
				detailViewController.imageStore = self.imageStore
			}
		}
	}

	override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
		if identifier == "ShowItem" {
			// Only perform the segue if it is not the last row
			if let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell)
				where indexPath.row < self.tableView(self.tableView, numberOfRowsInSection: indexPath.section) - 1 {
				return true
			}
			return false
		}

		return true
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)

		self.tableView.reloadData()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		self.navigationItem.leftBarButtonItem = self.editButtonItem()
	}
}
