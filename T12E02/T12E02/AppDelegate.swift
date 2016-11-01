//
//  AppDelegate.swift
//  T12E02
//
//  Created by jngd on 01/11/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		let settings = UIUserNotificationSettings(forTypes:
			[.Sound, .Alert, .Badge], categories: nil)
		UIApplication.sharedApplication().registerUserNotificationSettings(settings)
		return true
	}
	
	func applicationWillResignActive(application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}
	
	func applicationDidEnterBackground(application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}
	
	func applicationWillEnterForeground(application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}
	
	func applicationDidBecomeActive(application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}
	
	func applicationWillTerminate(application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
	
	func application(application: UIApplication,
	                 performFetchWithCompletionHandler completionHandler:
		(UIBackgroundFetchResult) -> Void) {
		
		let urlWeather = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=Murcia,es&appid=ff715187977ebda05fb3d205ffa044a0&units=metric")
		var temperature: AnyObject = ""
		let sesion = NSURLSession(configuration:
			NSURLSessionConfiguration.defaultSessionConfiguration())
		sesion.downloadTaskWithURL(urlWeather!) { (url, response, error) -> Void in
			
			let dataDownloaded = NSData(contentsOfURL: url!)
			
			do{
				let weather = try
					NSJSONSerialization.JSONObjectWithData(dataDownloaded!,
					                                       options: .AllowFragments)
				temperature = (weather["main"] as! NSDictionary)["temp"]!
				completionHandler(.NewData)
			}catch{
				print("Parse failed")
				completionHandler(.Failed)
			}
		}.resume()
		
		// Local notification with current temp
		let notification = UILocalNotification()
		notification.alertBody = "Current temp is \(temperature as! String)"
		notification.alertAction = "Ok"
		application.presentLocalNotificationNow(notification)
	}
}

