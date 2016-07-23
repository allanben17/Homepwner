//
//  AppDelegate.swift
//  Homepwner
//
//  Created by Tianyi Ben on 2016-06-04.
//  Copyright © 2016 Tianyi Ben. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	let itemStore = ItemStore()


	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		// Override point for customization after application launch.

		// Create an ImageStore
		let imageStore = ImageStore()

		//Get the ItemsViewController
		let navController = self.window?.rootViewController as! UINavigationController
		let itemsController = navController.topViewController as! ItemsViewController

		// Access the ItemsViewController and set its item store and image store
		itemsController.itemStore = self.itemStore
		itemsController.imageStore = imageStore

		print("Application bundle path: \(NSBundle.mainBundle().bundlePath)")

		return true
	}

	func applicationWillResignActive(application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

		print(#function)
	}

	func applicationDidEnterBackground(application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

		print(#function)

		let success = self.itemStore.saveChanges()
		if success {
			print("Saved all of the Items")
		} else {
			print("Could not save any of the Items")
		}
	}

	func applicationWillEnterForeground(application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

		print(#function)
	}

	func applicationDidBecomeActive(application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

		print(#function)
	}

	func applicationWillTerminate(application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

		print(#function)
	}


}

