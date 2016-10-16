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
		
		// Load filter
		let sepiaFilter : CIFilter = CIFilter(name: "CISepiaTone")!
		sepiaFilter.setValue(inputImage, forKey: kCIInputImageKey)
		sepiaFilter.setValue(0.8, forKey: "InputIntensity")
		inputImage = sepiaFilter.valueForKey(kCIOutputImageKey) as! CIImage
		
		// Set in imageView
		imageView.image = UIImage(CIImage: inputImage)
	}
	
	
	@IBAction func setVignetteFilter(sender: AnyObject) {

		// Load filter
		let vignetteFilter : CIFilter = CIFilter(name: "CIVignette")!
		vignetteFilter.setValue(inputImage, forKey: kCIInputImageKey)
		vignetteFilter.setValue(0.8, forKey: "inputIntensity")
		vignetteFilter.setValue(80, forKey: "inputRadius")
		inputImage = vignetteFilter.valueForKey(kCIOutputImageKey) as! CIImage
		
		// Set in imageView
		imageView.image = UIImage(CIImage: inputImage)
	}
	
	@IBAction func setPhotoEffectNoirFilter(sender: AnyObject) {

		// Load filter
		let photoEffectNoirFilter : CIFilter = CIFilter(name: "CIPhotoEffectNoir")!
		photoEffectNoirFilter.setValue(inputImage, forKey: kCIInputImageKey)
		inputImage = photoEffectNoirFilter.valueForKey(kCIOutputImageKey) as! CIImage
		
		// Set in imageView
		imageView.image = UIImage(CIImage: inputImage)
	}

	@IBAction func setMonocromeFilter(sender: AnyObject) {
		
		// Load filter
		let monocromeFilter : CIFilter = CIFilter(name: "CIColorMonochrome")!
		monocromeFilter.setValue(inputImage, forKey: kCIInputImageKey)
		inputImage = monocromeFilter.valueForKey(kCIOutputImageKey) as! CIImage
		
		// Set in imageView
		imageView.image = UIImage(CIImage: inputImage)
	}

	@IBAction func restoreDefaultPhoto(sender: AnyObject) {

		let filePath : String = NSBundle.mainBundle().pathForResource("cph", ofType: "jpg")!
		let fileUrl : NSURL = NSURL(fileURLWithPath: filePath)
		inputImage = CIImage(contentsOfURL: fileUrl)!
		imageView.image = UIImage(CIImage: inputImage)
	}
	
	@IBAction func setInvertFilter(sender: AnyObject) {
		
		// Load filter
		let invertFilter : CIFilter = CIFilter(name: "CIColorInvert")!
		invertFilter.setValue(inputImage, forKey: kCIInputImageKey)
		inputImage = invertFilter.valueForKey(kCIOutputImageKey) as! CIImage
		
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

