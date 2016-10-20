//
//  ViewController.swift
//  T11E01
//
//  Created by jngd on 20/10/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let moviePath = NSURL(string: "http://www.imaginaformacion.com/recursos/videos/trailerjobs.mp4")
		
		let player = AVPlayer(URL: moviePath!)
		let playerLayer = AVPlayerLayer(player: player)
		
		playerLayer.frame = CGRectMake(10, 10, 300, 225)
		self.view.layer.addSublayer(playerLayer)
		player.play()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
}

