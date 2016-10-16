//
//  ViewController.swift
//  T6E01
//
//  Created by jngd on 16/10/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
	
	/***** Vars *****/
	var inputImage : CIImage!
	
	/***** Outlets *****/
	@IBOutlet weak var imageView: UIImageView!
	
	/***** Actions *****/
	@IBAction func setSepiaFilter(sender: AnyObject) {
		
		// Load sepia filter
		let sepiaFilter : CIFilter = CIFilter(name: "CISepiaTone")!
		sepiaFilter.setValue(inputImage, forKey: kCIInputImageKey)
		sepiaFilter.setValue(0.8, forKey: "InputIntensity")
		inputImage = sepiaFilter.valueForKey(kCIOutputImageKey) as! CIImage
		
		// Set in imageView
		imageView.image = UIImage (CIImage: inputImage)
	}
	
	
	@IBAction func setVignetteFilter(sender: AnyObject) {

		// Load vignette filter
		let vignetteFilter : CIFilter = CIFilter(name: "CIVignette")!
		vignetteFilter.setValue(inputImage, forKey: kCIInputImageKey)
		vignetteFilter.setValue(0.8, forKey: "inputIntensity")
		vignetteFilter.setValue(80, forKey: "inputRadius")
		inputImage = vignetteFilter.valueForKey(kCIOutputImageKey) as! CIImage
		
		// Set in imageView
		imageView.image = UIImage (CIImage: inputImage)

	}
	

	@IBAction func setInvertFilter(sender: AnyObject) {
		// Load vignette filter
		let vignetteFilter : CIFilter = CIFilter(name: "CIColorInvert")!
		vignetteFilter.setValue(inputImage, forKey: kCIInputImageKey)
		inputImage = vignetteFilter.valueForKey(kCIOutputImageKey) as! CIImage
		
		// Set in imageView
		imageView.image = UIImage (CIImage: inputImage)
	}
	
	
	/***** Methods *****/
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Load image reference
		let filePath : String = NSBundle.mainBundle().pathForResource("cph", ofType: "jpg")!
		let fileUrl : NSURL = NSURL(fileURLWithPath: filePath)
		inputImage = CIImage(contentsOfURL: fileUrl)!
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	
}

