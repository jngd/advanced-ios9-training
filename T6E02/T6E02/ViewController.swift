//
//  ViewController.swift
//  T6E02
//
//  Created by jngd on 18/10/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	/***** Vars ******/
	var filePath : String = ""
	var fileNameAndPath : NSURL = NSURL()
	var image : CIImage = CIImage()
	
	/***** Methods *****/
	override func viewDidLoad() {
		super.viewDidLoad()
		
		filePath = NSBundle.mainBundle().pathForResource("photo-peace", ofType: "jpg")!
		
		fileNameAndPath = NSURL.fileURLWithPath(filePath)
		image = CIImage(contentsOfURL: fileNameAndPath)!
		
		let context = CIContext(options: nil)
		let options : Dictionary<String, AnyObject> =
			[CIDetectorAccuracy: CIDetectorAccuracyHigh]
		let detector = CIDetector(ofType: CIDetectorTypeFace,
									   context: context, options: options)
		
		let features : NSArray = detector.featuresInImage(image,
									  options: [CIDetectorSmile: true, CIDetectorEyeBlink: true])
		
		let imageView = UIImageView(image: UIImage(named: "photo-peace.jpg"))
		self.view.addSubview(imageView)
		
		let auxView = UIView(frame: imageView.frame)
		
		for faceFeature in features {
			// Face detection
			let smile = faceFeature.hasSmile
			let rightEyeBlinking = faceFeature.rightEyeClosed
			let leftEyeBlinking = faceFeature.leftEyeClosed
			let faceRect = faceFeature.bounds
			let faceView = UIView(frame: faceRect)
			faceView.layer.borderWidth = 2
			faceView.layer.borderColor = UIColor.redColor().CGColor
			let faceWidth:CGFloat = faceRect.size.width
			auxView.addSubview(faceView)
		}
		
		self.view.addSubview(auxView)
		auxView.transform = CGAffineTransformMakeScale(1, -1)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

