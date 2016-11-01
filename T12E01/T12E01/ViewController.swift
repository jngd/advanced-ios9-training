//
//  ViewController.swift
//  T12E01
//
//  Created by jngd on 30/10/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSURLConnectionDelegate,
NSXMLParserDelegate, UITableViewDelegate {
	
	@IBOutlet weak var table: UITableView!
	
	var apps: Array<AppInfo> = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		apps = [AppInfo]()
		
		getData();
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	func getData() {
		let queue = NSOperationQueue()
		
		queue.maxConcurrentOperationCount = 1
		
		let dataOperation = DataOperation()
		dataOperation.apps = self.apps
		dataOperation.delegate = self
		dataOperation.completionBlock = {
			
		}
		queue.addOperation(dataOperation)
	}
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return apps.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)
		let appTmp = self.apps[indexPath.row]
		cell.textLabel?.text = appTmp.name
		cell.imageView?.image = appTmp.image
		return cell
	}
}

// MARK: - ImagesOperationDelegate
extension ViewController: ImagesOperationDelegate {
	
	func imageOperation(imagesOperations: ImagesOperation, appData: AppInfo) {
		var visibleCells = table.visibleCells
		let firstIndex = table.indexPathForCell(visibleCells[0] as UITableViewCell)?.row
		let lastIndex = table.indexPathForCell(visibleCells.last! as UITableViewCell)?.row
		
		if (appData.index < firstIndex || appData.index > lastIndex) {return}
		
		let indexPath = NSIndexPath(forRow: appData.index, inSection: 0)
		let cell = table.cellForRowAtIndexPath(indexPath)
		
		dispatch_async(dispatch_get_main_queue(), {() -> Void in
			cell?.imageView!.image = appData.image
			self.table.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
			}
		)
	}
}

// MARK: - ImagesOperationDelegate
extension ViewController: DataOperationDelegate {
	
	func dataOperation(dataOperations: DataOperation, appData: [AppInfo]) {
		self.apps = appData
		
		// TODO : Is this safe?
		let queue = NSOperationQueue()
		
		for it in apps {
			let imagesOperation = ImagesOperation()
			imagesOperation.app = it as AppInfo
			imagesOperation.delegate = self
			queue.addOperation(imagesOperation)
		}
		
		dispatch_async(dispatch_get_main_queue(), {() -> Void in
			self.table.reloadData()
		})
	}
}
// :]