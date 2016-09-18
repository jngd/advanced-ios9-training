//
//  CustomSegue.swift
//  T2E02
//
//  Created by jngd on 18/09/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit
import QuartzCore

class CustomSegue: UIStoryboardSegue {
	override func perform(){
		var source : UIViewController = self.source as UIViewController
		var destination : UIViewController = self.destination as UIViewController
		
		UIGraphicsBeginImageContext(source.view.bounds.size)
		source.view.layer.render(in: UIGraphicsGetCurrentContext()!)
		
		let sourceImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
		
		destination.view.layer.render(in: UIGraphicsGetCurrentContext()!)
		
		let destinationImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
		
		UIGraphicsEndImageContext()
		
		let sourceImageView : UIImageView = UIImageView(image: sourceImage)
		let destinationImageView : UIImageView = UIImageView(image: destinationImage)
		
		source.view.addSubview(sourceImageView)
		source.view.addSubview(destinationImageView)
		
		destinationImageView.transform =
			CGAffineTransform(scaleX: destinationImageView.frame.size.width, y: 0)
		
		UIView.animate(withDuration: 1.0, animations: {
			() in sourceImageView.transform =
				CGAffineTransform(scaleX: sourceImageView.frame.size.width, y: 0)
			}, completion: { (finished) in
				source.present( destination, animated: false,
				                completion: { () -> Void in
													sourceImageView.removeFromSuperview()
													destinationImageView.removeFromSuperview()
				})
		})
	}
}
