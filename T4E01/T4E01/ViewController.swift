//
//  ViewController.swift
//  T4E01
//
//  Created by jngd on 26/09/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
UIPopoverPresentationControllerDelegate{
	
	@IBOutlet weak var helpMe: UIButton!
	
	@IBAction func buttonHelpMe(sender: AnyObject) {

		let popoverContent : UIViewController = UIViewController()

		popoverContent.view.backgroundColor = UIColor.redColor()
		popoverContent.modalPresentationStyle =
			UIModalPresentationStyle.Popover
		
		let label = UILabel(frame: CGRectMake(0, 150, 300, 50))
		
		label.text = "¡Hola Popover!"
		label.textAlignment = NSTextAlignment.Center
		popoverContent.view.addSubview(label)
		
		let popover = popoverContent.popoverPresentationController as
			UIPopoverPresentationController?
		
		popoverContent.preferredContentSize = CGSizeMake(300, 300)
		popover?.delegate = self
		popover?.sourceView = sender as! UIButton
		popover?.permittedArrowDirections = UIPopoverArrowDirection.Up
		popover?.sourceRect = CGRectMake(10, 20, 0, 0)
		self.presentViewController(popoverContent, animated: true,
		                           completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
}

