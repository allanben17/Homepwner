//
//  ItemStore.swift
//  Homepwner
//
//  Created by Tianyi Ben on 2016-06-18.
//  Copyright © 2016 Tianyi Ben. All rights reserved.
//

import UIKit

class ItemStore {

	var allItems = [Item]()

	func createItem() -> Item {
		let newItem = Item(random: true)

		self.allItems.append(newItem)

		return newItem
	}

	func removeItem(item: Item) {
		if let index = self.allItems.indexOf(item) {
			self.allItems.removeAtIndex(index)
		}
	}

	func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
		if fromIndex == toIndex {
			return
		}

		// Get reference to object being moved so you can reinsert it
		let movedItem = allItems[fromIndex]

		// Remove item from array
		allItems.removeAtIndex(fromIndex)

		// Insert item in array at new location
		allItems.insert(movedItem, atIndex: toIndex)
	}
}
