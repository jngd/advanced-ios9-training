//
//  ViewController.swift
//  T2E02
//
//  Created by jngd on 18/09/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if (segue.identifier == "CustomSegue"){
			let dest = segue.destination as! SecondViewController
			dest.labelString = "Hello world"
		}
	}
}

