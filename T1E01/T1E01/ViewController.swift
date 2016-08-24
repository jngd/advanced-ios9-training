//
//  ViewController.swift
//  T1E01
//
//  Created by jngd on 24/08/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		print("Juan Garcia")
		
		var vector : [Int] = []
		
		for _ in 1...10 {
			vector.append(Int(arc4random_uniform(1000)))
		}
		
		let result = addVectorElements(vector)
		
		print(result)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func addVectorElements(vector: [Int]) -> Int {
		return vector.reduce(0, combine: +)
	}

}

