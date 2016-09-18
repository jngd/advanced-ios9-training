//
//  BounceTransition.swift
//  T2E04
//
//  Created by jngd on 18/09/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

class BounceTransition: NSObject, UIViewControllerAnimatedTransitioning {
	
	func transitionDuration(using transitionContext:
		UIViewControllerContextTransitioning?) -> TimeInterval {
		return 2.0
	}
	
	func animateTransition(using transitionContext:
		UIViewControllerContextTransitioning)  {
		
		let toViewController : UIViewController =
			transitionContext.viewController(
				forKey: UITransitionContextViewControllerKey.to)!
		
		let fromViewController : UIViewController =
			transitionContext.viewController(
				forKey: UITransitionContextViewControllerKey.from)!
		
		let screenBounds : CGRect = UIScreen.main.bounds
		let containerView : UIView = transitionContext.containerView
		
		containerView.addSubview(fromViewController.view)
		containerView.addSubview(toViewController.view)
		
		toViewController.view.frame = screenBounds.offsetBy(dx: 0,
		                                                    dy: screenBounds.size.height)
		let duration : TimeInterval =
			transitionDuration(using: transitionContext)
		
		UIView.animate(withDuration: 0.4, animations: {() in
			fromViewController.view.transform =
				CGAffineTransform(scaleX: 0.9, y: 0.9)
			}, completion: {(finished) in
				UIView.animate(withDuration: duration-0.4, delay: 0.0,
				               usingSpringWithDamping: 0.35, initialSpringVelocity: 0.5, options:
					UIViewAnimationOptions.curveLinear, animations: {() in
						toViewController.view.frame = screenBounds
					}, completion: {(finished) in
						transitionContext.completeTransition(true)
				})
		})
	}
}
