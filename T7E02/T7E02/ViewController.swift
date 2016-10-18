//
//  ViewController.swift
//  T7E02
//
//  Created by jngd on 18/10/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let notification = UILocalNotification()
		
		notification.fireDate = NSDate().dateByAddingTimeInterval(10)
		notification.alertBody = "Alert"

		UIApplication.sharedApplication().scheduleLocalNotification(notification)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

