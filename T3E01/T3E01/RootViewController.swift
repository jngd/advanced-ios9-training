//
//  RootViewController.swift
//  T3E01
//
//  Created by jngd on 25/09/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIPageViewControllerDelegate {
	
	var pageViewController: UIPageViewController?
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		// Configure the page view controller and add it as a child view controller.
		self.pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
		self.pageViewController!.delegate = self
		
		let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
		let viewControllers = [startingViewController]
		self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })
		
		self.pageViewController!.dataSource = self.modelController
		
		self.addChildViewController(self.pageViewController!)
		self.view.addSubview(self.pageViewController!.view)
		
		// Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
		var pageViewRect = self.view.bounds
		if UIDevice.current.userInterfaceIdiom == .pad {
			pageViewRect = pageViewRect.insetBy(dx: 40.0, dy: 40.0)
		}
		self.pageViewController!.view.frame = pageViewRect
		
		self.pageViewController!.didMove(toParentViewController: self)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	var modelController: ModelController {
		// Return the model controller object, creating it if necessary.
		// In more complex implementations, the model controller may be passed to the view controller.
		if _modelController == nil {
			_modelController = ModelController()
		}
		return _modelController!
	}
	
	var _modelController: ModelController? = nil
	
	// MARK: - UIPageViewController delegate methods
	
	func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
		
		if (UIInterfaceOrientationIsLandscape(orientation)) {
			
			let currentViewController = self.pageViewController!.viewControllers![0] as! DataViewController
			
			var viewControllers : [UIViewController] = [currentViewController]
			
			let indexOfCurrentViewController =
				self.modelController.indexOfViewController(currentViewController)
			
			if (indexOfCurrentViewController == 0 || indexOfCurrentViewController % 2 == 0) {
				
				let nextViewController : UIViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerAfter: currentViewController)!
				
				viewControllers = [currentViewController, nextViewController]
				
			} else {
				
				let previousViewController:UIViewController =
					self.modelController.pageViewController(self.pageViewController!,
					  viewControllerBefore: currentViewController)!
				
				viewControllers = [previousViewController,currentViewController]
			}
			
			self.pageViewController?.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
			return UIPageViewControllerSpineLocation.mid
			
		} else {
			
			let currentViewController =
				self.pageViewController!.viewControllers![0] as UIViewController
			
			let viewControllers : [UIViewController] = [currentViewController]
			
			self.pageViewController!.setViewControllers(viewControllers,
			  direction: .forward, animated: true, completion: {done in })
			
			self.pageViewController!.isDoubleSided = false
			
			return UIPageViewControllerSpineLocation.min

		}
	}	
}

