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
		
		let config = NSURLSessionConfiguration.defaultSessionConfiguration()
		config.allowsCellularAccess = true
		
		let session = NSURLSession(configuration: config)
		session.downloadTaskWithURL(NSURL(
			string: "https://itunes.apple.com/es/rss/topfreeapplications/limit=50/json")!) {
				(url, response, error) -> Void in
				
				print(url)
				
				let dataTopApps = NSData(contentsOfURL: url!)
				var dicTopApps : NSDictionary!
				
				do {
					dicTopApps = try NSJSONSerialization.JSONObjectWithData(
						dataTopApps!,
						options: NSJSONReadingOptions.MutableLeaves) as! NSDictionary
					
					let applications = (dicTopApps["feed"] as! NSDictionary) ["entry"] as!
						[NSDictionary]
					print(applications)
					
					for app in applications {
						let appTemp = AppInfo()
						appTemp.name = (app["im:name"] as! NSDictionary) ["label"] as! String
						appTemp.index = self.apps.count
						appTemp.urlApp = ((app["link"] as! NSDictionary)["attributes"] as!
							NSDictionary)["href"] as! String
						appTemp.urlImage = (((app["im:image"]
							as! NSArray)[2] as! NSDictionary)["label"] as! String)
						self.apps.append(appTemp)
					}
					
					dispatch_async(dispatch_get_main_queue(), {() -> Void in
						self.table.reloadData()
					})
					
					// Do that into NSOperation
					self.getImages()
				} catch {
					print("Parse failed")
				}
			}.resume()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	func getImages() {
		let queue = NSOperationQueue()
		
		for it in apps {
			let imagesOperation = ImagesOperation()
			imagesOperation.app = it as AppInfo
			imagesOperation.delegate = self
			queue.addOperation(imagesOperation)
		}
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
		self.table.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)})
	}
}

// :]