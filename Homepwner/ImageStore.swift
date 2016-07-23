//
//  ImageStore.swift
//  Homepwner
//
//  Created by Tianyi Ben on 2016-07-16.
//  Copyright © 2016 Tianyi Ben. All rights reserved.
//

import UIKit

class ImageStore {

	let cache = NSCache()

	func setImage(image: UIImage, forKey key: String) {
		cache.setObject(image, forKey: key)

		// Create full URL for image
		let imageURL = self.imageURLForKey(key)

		// Turn iamge into JPEG data
		if let data = UIImagePNGRepresentation(image) {
			// Write it to full URL
			data.writeToURL(imageURL, atomically: true)
		}
	}

	func imageForKey(key: String) -> UIImage? {

		if let existingImage = self.cache.objectForKey(key) as? UIImage {
			return existingImage
		}

		let imageURL = self.imageURLForKey(key)
		guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path!) else {
			return nil
		}

		self.cache.setObject(imageFromDisk, forKey: key)
		return imageFromDisk
	}

	func deleteImageForKey(key: String) {
		cache.removeObjectForKey(key)

		let imageURL = self.imageURLForKey(key)
		do {
			try NSFileManager.defaultManager().removeItemAtURL(imageURL)
		} catch let deleteError {
			print("Error removing the image from disk: \(deleteError)")
		}
	}

	func imageURLForKey(key: String) -> NSURL {

		let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
		let documentDirectory = documentsDirectories.first!

		return documentDirectory.URLByAppendingPathComponent(key)
	}
}
