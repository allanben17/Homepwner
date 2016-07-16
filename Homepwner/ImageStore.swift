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
	}

	func imageForKey(key: String) -> UIImage? {
		return cache.objectForKey(key) as? UIImage
	}

	func deleteImageForKey(key: String) {
		cache.removeObjectForKey(key)
	}

}
