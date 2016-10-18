//
//  ViewController.swift
//  T7E01
//
//  Created by jngd on 18/10/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
UITextFieldDelegate {

	/***** Outlets *****/
	@IBOutlet weak var textField: UITextField!

	/***** Methods *****/
	override func viewDidLoad() {
		super.viewDidLoad()
		
		textField.delegate = self
		
		// Register controller as observer
		NSNotificationCenter.defaultCenter().addObserver(self,
	    selector: #selector(ViewController.keyboardWillAppear(_:)),
		  name: UIKeyboardWillShowNotification,
		  object: nil)
		
		NSNotificationCenter.defaultCenter().addObserver(self,
		  selector: #selector(ViewController.keyboardWillDisappear(_:)),
			name: UIKeyboardWillHideNotification,
      object: nil)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func textField(textField: UITextField, shouldChangeCharactersInRange
		range: NSRange,
		replacementString string: String) -> Bool {
		
		if (string == "\n") {
			textField.resignFirstResponder()
			return false
		} else {
			return true
		}
	}
	
	func keyboardWillAppear(notification: NSNotification) {
		print("Keyboard appear")
	}
	
	func keyboardWillDisappear(notification: NSNotification) {
		print("Keyboard dissapear")
	}
}

