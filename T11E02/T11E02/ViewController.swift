//
//  ViewController.swift
//  T11E02
//
//  Created by jngd on 20/10/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	/***** Vars *****/
	
	var player : AVPlayer = AVPlayer()
	var playerLayer : AVPlayerLayer = AVPlayerLayer()
	
	/***** Outlets *****/
	@IBOutlet weak var secondsLabel: UILabel!
	
	/***** Actions *****/
	@IBAction func sliderValueChanged(sender: AnyObject) {
		player.volume = sender.value
	}
	
	@IBAction func playButton(sender: AnyObject) {
		
		if (player.status != AVPlayerStatus.ReadyToPlay) {
			print("Player is not ready")
			return;
		}
		
		player.play()
	}
	
	@IBAction func pauseButton(sender: AnyObject) {
		player.pause()
	}
	
	@IBAction func stopButton(sender: AnyObject) {
		player.pause()
		player.seekToTime(CMTime(seconds: 0.0, preferredTimescale: 1))
	}
	
	
	/***** Methods *****/
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let moviePath = NSURL(string: "http://www.imaginaformacion.com/recursos/videos/trailerjobs.mp4")
		
		secondsLabel.text = "sec"
		player = AVPlayer(URL: moviePath!)
		playerLayer = AVPlayerLayer(player: player)
		
		playerLayer.frame = CGRectMake(10, 10, 300, 225)
		player.addPeriodicTimeObserverForInterval(CMTime(seconds: 1.0,
			preferredTimescale: 1), queue: nil) { (time) -> Void in
				let valor = time.value as Int64
				let timestamp = time.timescale as Int32
				let res = Int(valor) / Int(timestamp)
				self.secondsLabel.text = res.description
		}

		self.view.layer.addSublayer(playerLayer)
		player.play()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

