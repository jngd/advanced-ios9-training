//
//  ViewController.swift
//  T6E03
//
//  Created by jngd on 17/10/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,
AVCaptureMetadataOutputObjectsDelegate{
	
	/***** Vars *****/
	var previewLayer : AVCaptureVideoPreviewLayer!
	var captureSession : AVCaptureSession!
	var metadataOutput : AVCaptureMetadataOutput!
	var videoDevice :AVCaptureDevice!
	var videoInput : AVCaptureDeviceInput!
	var running = false
	
	/***** Outlets *****/
	@IBOutlet weak var previewView: UIView!
	
	/***** Methods *****/
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupCaptureSession()
		
		previewLayer.frame = previewView.bounds
		
		NSNotificationCenter.defaultCenter().addObserver(
			self,
			selector: #selector(ViewController.startRunning),
			name: UIApplicationWillEnterForegroundNotification,
			object: nil
		)
		
		NSNotificationCenter.defaultCenter().addObserver(
			self,
			selector: #selector(ViewController.stopRunning),
			name: UIApplicationDidEnterBackgroundNotification,
			object: nil
		)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func startRunning() {
		captureSession.startRunning()
		metadataOutput.metadataObjectTypes =
			metadataOutput.availableMetadataObjectTypes
		running = true
	}
	
	func stopRunning() {
		captureSession.stopRunning()
		running = true
	}
	
	func setupCaptureSession() {
		
		if (captureSession != nil) {return}
		
		videoDevice =
			AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
		
		if (videoDevice == nil) {
			print ("No camera available")
			return
		}
		
		captureSession = AVCaptureSession()
		
		do {
			videoInput = try AVCaptureDeviceInput(device: videoDevice)
		} catch {
			print ("Error specifying capture device")
		}
		
		if (captureSession.canAddInput(videoInput)) {
			captureSession.addInput(videoInput)
		}
		
		previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
		previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
		
		metadataOutput = AVCaptureMetadataOutput()
		
		let metadataQueue = dispatch_queue_create("com.jngd.T6E03.metadata", nil)
		
		metadataOutput.setMetadataObjectsDelegate(self, queue: metadataQueue)
		
		if (captureSession.canAddOutput(metadataOutput)) {
			captureSession.addOutput(metadataOutput)
		}
	}
	
	func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects
		metadataObjects: [AnyObject]!, fromConnection connection:
		AVCaptureConnection!) {
		
		let element = metadataObjects.first as? AVMetadataMachineReadableCodeObject

		if(element == nil) {return}
		
		print(element!.stringValue)
	}
}

