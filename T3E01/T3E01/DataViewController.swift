//
//  DataViewController.swift
//  T3E01
//
//  Created by jngd on 25/09/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

	@IBOutlet weak var dataLabel: UILabel!
	var dataObject: String = ""


	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.dataLabel!.text = dataObject
	}


}

