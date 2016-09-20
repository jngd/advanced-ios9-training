//
//  ViewController.swift
//  T2E04
//
//  Created by jngd on 18/09/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
UIViewControllerTransitioningDelegate {
	
	var bounce : BounceTransition!
	
	override func viewDidLoad() {
		self.bounce = BounceTransition()
		super.viewDidLoad()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender:
		Any?) {
		if (segue.identifier == "showCustomTransition"){
			let toVC : UIViewController = segue.destination
				as UIViewController
			toVC.transitioningDelegate = self
		}
	}
	
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return self.bounce
	}
}

