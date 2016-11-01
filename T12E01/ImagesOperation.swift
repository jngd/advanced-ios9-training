//
//  ImagesOperation.swift
//  T12E01
//
//  Created by jngd on 30/10/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

protocol ImagesOperationDelegate {
	func imageOperation(imagesOperations: ImagesOperation, appData: AppInfo)
}

protocol DataOperationDelegate {
	func dataOperation(dataOperations: DataOperation, appData: [AppInfo])
}

class DataOperation: NSOperation {
	
	let dataURL = "https://itunes.apple.com/es/rss/topfreeapplications/limit=50/json"
	
	var delegate: DataOperationDelegate?
	var apps: Array<AppInfo> = []
	
	override func main() {
		let session = NSURLSession(configuration:
			NSURLSessionConfiguration.defaultSessionConfiguration())
		
		session.downloadTaskWithURL(NSURL(string: dataURL)!) {
			(url,response,error) -> Void in
			
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
				
			} catch {
				print("Parse failed")
			}
			
			self.delegate?.dataOperation(self, appData: self.apps)
			}.resume()
	}
}

class ImagesOperation: NSOperation {
	
	var delegate: ImagesOperationDelegate?
	var app: AppInfo!
	
	override func main() {
		
		let session = NSURLSession(configuration:
			NSURLSessionConfiguration.defaultSessionConfiguration())
		
		session.downloadTaskWithURL(NSURL(string: app.urlImage)!) {
			(url,response,error) -> Void in
			let image = UIImage(data: NSData(contentsOfURL: url!)!)
			self.app.image = image
			self.delegate?.imageOperation(self, appData: self.app)
			}.resume()
	}
}