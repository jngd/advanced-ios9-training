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