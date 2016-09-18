//
//  SecondViewController.swift
//  T2E04
//
//  Created by jngd on 18/09/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,
UIViewControllerTransitioningDelegate {
	
	var crossfade : CrossfadeTransition!
	
	override func viewDidLoad() {
		self.crossfade = CrossfadeTransition()
		super.viewDidLoad()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	func prepareForSegue(segue: UIStoryboardSegue, sender:
		AnyObject?) {
		if (segue.identifier == "showCrossfadeTransition"){
			let toVC : UIViewController = segue.destination
				as UIViewController
			toVC.transitioningDelegate = self
		}
	}
	
	func animationController(forPresented presented: UIViewController,
	                         presenting: UIViewController,
	                         source: UIViewController) ->
		UIViewControllerAnimatedTransitioning? {
		return self.crossfade
	}
}
