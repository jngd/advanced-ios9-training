//
//  ViewController.swift
//  T20E01
//
//  Created by jngd on 03/12/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
	var appDel:AppDelegate!
	var context:NSManagedObjectContext!
	var request : NSFetchRequest!

	override func viewDidLoad() {
		super.viewDidLoad()
		appDel = UIApplication.sharedApplication().delegate as! AppDelegate
		context = appDel.managedObjectContext
		loadTabla()
	}
}

