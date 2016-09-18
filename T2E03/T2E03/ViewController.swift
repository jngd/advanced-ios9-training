//
//  ViewController.swift
//  T2E03
//
//  Created by jngd on 18/09/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBAction func buttonActionWithoutStoryboard(_ sender: AnyObject) {
		var controller : XIBViewController = XIBViewController()
		self.present(controller, animated: true, completion: nil)
	}

	@IBAction func buttonAction(_ sender: AnyObject) {
		var storyboard = UIStoryboard(name: "Main", bundle:
			Bundle.main)
		var viewController:UIViewController =
			storyboard.instantiateViewController(withIdentifier: "NewViewController"
				) as UIViewController
		self.present(viewController, animated: true,
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

