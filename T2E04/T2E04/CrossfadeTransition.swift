//
//  CrossfadeTransition.swift
//  T2E04
//
//  Created by jngd on 18/09/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

class CrossfadeTransition: NSObject, UIViewControllerAnimatedTransitioning {
	
	func transitionDuration(using transitionContext:
		UIViewControllerContextTransitioning?) -> TimeInterval {
		return 10.0
	}
	
	func animateTransition(using transitionContext:
		UIViewControllerContextTransitioning) {
		let toView: UIView =
			transitionContext.view(forKey: UITransitionContextViewKey.to)!
		let fromView: UIView =
			transitionContext.view(forKey: UITransitionContextViewKey.from)!
		let containerView: UIView = transitionContext.containerView
		containerView.addSubview(toView)
		containerView.sendSubview(toBack: toView)
		var	duration:TimeInterval =
			self.transitionDuration(using: transitionContext)
		UIView.animate(withDuration: duration, animations: {() in
			fromView.alpha = 0.0
			},completion: {(finished) in
				if(transitionContext.transitionWasCancelled){
					fromView.alpha = 1.0
				}else{
					fromView.removeFromSuperview()
					fromView.alpha = 1.0
				}
				transitionContext.completeTransition(true)
		})
	}
}
