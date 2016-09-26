//
//  ViewController.swift
//  T4E01
//
//  Created by jngd on 26/09/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
	UIPopoverPresentationControllerDelegate,
UITableViewDelegate, UITableViewDataSource {
	
	let helpOptions : [String] = ["Option1", "Option2", "Option3"]
	
	var tableView : UITableView = UITableView()
	
	@IBOutlet weak var helpMe: UIButton!
	
	@IBAction func buttonHelpMe(sender: AnyObject) {
		
		let contenidoPopover : UIViewController = UIViewController ()
		contenidoPopover.modalPresentationStyle =
			UIModalPresentationStyle.Popover
		
		tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
		contenidoPopover.view.addSubview(self.tableView)
		
		let popover = contenidoPopover.popoverPresentationController as
			UIPopoverPresentationController?
		contenidoPopover.preferredContentSize = CGSizeMake(300, 300)
		popover?.delegate = self
		popover?.sourceView = sender as! UIButton
		popover?.permittedArrowDirections = UIPopoverArrowDirection.Up
		popover?.sourceRect = CGRectMake(10, 20, 0, 0)
		
		self.presentViewController(contenidoPopover, animated: true,
		                           completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.helpOptions.count;
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
		-> UITableViewCell {
		
		let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
		cell.textLabel!.text = helpOptions[indexPath.row]
		return cell;
	}
	
}

