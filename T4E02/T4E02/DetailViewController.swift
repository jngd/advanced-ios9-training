//
//  DetailViewController.swift
//  T4E02
//
//  Created by jngd on 26/09/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

	@IBOutlet weak var webView: UIWebView!
	@IBOutlet weak var detailDescriptionLabel: UILabel!


	var detailItem: AnyObject? {
		didSet {
		    // Update the view.
		    self.configureView()
		}
	}

	func configureView() {
		if let detail: AnyObject = detailItem {
			
			if let myWebview = webView {
				let url = NSURL(string: detail as! String)
				let request = NSURLRequest(URL: url!)
				myWebview.scalesPageToFit = true
				myWebview.loadRequest(request)
			}
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.configureView()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

