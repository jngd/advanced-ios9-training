//
//  SecondViewController.swift
//  T2E02
//
//  Created by jngd on 18/09/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
	
	var labelString : String?
	
	@IBOutlet weak var label : UILabel!
	
	@IBAction func goBack(_ sender: AnyObject) {
		
		self.dismiss(animated: false, completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		label.text = labelString
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
}
