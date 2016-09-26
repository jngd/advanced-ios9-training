//
//  MasterViewController.swift
//  T4E02
//
//  Created by jngd on 26/09/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
	
	var webs : [String]?
	var websAddresses : [String]?
	
	var detailViewController: DetailViewController? = nil
	var objects = [AnyObject]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		webs = ["Google", "Meneame", "Github", "Apple"]
		websAddresses = ["https://www.google.es",
		                 "https://www.meneame.net",
		                 "https://github.com",
		                 "https://www.apple.com/es/"]
		// Do any additional setup after loading the view, typically from a nib.
		self.navigationItem.leftBarButtonItem = self.editButtonItem()
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(insertNewObject(_:)))
		self.navigationItem.rightBarButtonItem = addButton
		if let split = self.splitViewController {
			let controllers = split.viewControllers
			self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
		}
	}
	
	override func viewWillAppear(animated: Bool) {
		self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
		super.viewWillAppear(animated)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func insertNewObject(sender: AnyObject) {
		objects.insert(NSDate(), atIndex: 0)
		let indexPath = NSIndexPath(forRow: 0, inSection: 0)
		self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
	}
	
	// MARK: - Segues
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showDetail" {
			if let indexPath = self.tableView.indexPathForSelectedRow {
				let urlString = websAddresses?[indexPath.row]
				
				let controller = (segue.destinationViewController
					as! UINavigationController).topViewController
					as! DetailViewController
				
				controller.detailItem = urlString
				controller.navigationItem.leftBarButtonItem =
					splitViewController?.displayModeButtonItem()
				controller.navigationItem.leftItemsSupplementBackButton
					= true
			}
		}
	}
	
	// MARK: - Table View
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (webs?.count)!
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
		
		cell.textLabel!.text = webs![indexPath.row]
		return cell
	}
	
	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}
	
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
			objects.removeAtIndex(indexPath.row)
			tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
		} else if editingStyle == .Insert {
			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
		}
	}
}

