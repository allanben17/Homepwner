//
//  Item.swift
//  Homepwner
//
//  Created by Tianyi Ben on 2016-06-04.
//  Copyright © 2016 Tianyi Ben. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
	var name: String
	var valueInDollars: Int
	var serialNumber: String?
	var dateCreated: NSDate
	let itemKey: String

	init(name: String, serialNumber: String?, valueInDollars: Int) {
		self.name = name
		self.valueInDollars = valueInDollars
		self.serialNumber = serialNumber
		self.dateCreated = NSDate()
		self.itemKey = NSUUID().UUIDString

		super.init()
	}

	convenience init(random: Bool = false) {
		if random {
			let adjectives = ["Fluffy", "Rusty", "Shiny"]
			let nouns = ["Bear", "Spork", "Mac"]

			var idx = arc4random_uniform(UInt32(adjectives.count))
			let randomAdjective = adjectives[Int(idx)]

			idx = arc4random_uniform(UInt32(nouns.count))
			let randomNoun = nouns[Int(idx)]

			let randomName = "\(randomAdjective) \(randomNoun)"
			let randomValue = Int(arc4random_uniform(100))
			let randomSerialNumber = NSUUID().UUIDString.componentsSeparatedByString("-").first!

			self.init(name: randomName, serialNumber: randomSerialNumber, valueInDollars: randomValue)
		} else {
			self.init(name: "", serialNumber: nil, valueInDollars: 0)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		self.name = aDecoder.decodeObjectForKey("name") as! String
		self.dateCreated = aDecoder.decodeObjectForKey("dateCreated") as! NSDate
		self.itemKey = aDecoder.decodeObjectForKey("itemKey") as! String
		self.serialNumber = aDecoder.decodeObjectForKey("serialNumber") as! String?

		self.valueInDollars = aDecoder.decodeIntegerForKey("valueInDollars")

		super.init()
	}

	func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(self.name, forKey: "name")
		aCoder.encodeObject(self.dateCreated, forKey: "dateCreated")
		aCoder.encodeObject(self.itemKey, forKey: "itemKey")
		aCoder.encodeObject(self.serialNumber, forKey: "serialNumber")

		aCoder.encodeInteger(self.valueInDollars, forKey: "valueInDollars")
	}
}
