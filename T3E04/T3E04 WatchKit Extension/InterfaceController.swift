//
//  InterfaceController.swift
//  T3E04 WatchKit Extension
//
//  Created by jngd on 25/09/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
	
	@IBOutlet var sliderOutlet: WKInterfaceSlider!
	@IBOutlet var pickerOutlet: WKInterfacePicker!
	
	@IBAction func buttonAction() {
		
		let cancel = WKAlertAction(title: "Cancel", style:
			WKAlertActionStyle.Cancel, handler: { () -> Void in
		})
		
		let action = WKAlertAction(title: "Accept", style:
			WKAlertActionStyle.Default, handler: { () -> Void in
		})
		
		self.presentAlertControllerWithTitle("Title", message: "Alert message",
		  preferredStyle: WKAlertControllerStyle.SideBySideButtonsAlert,
		  actions: [cancel, action])
	}
	
	override func awakeWithContext(context: AnyObject?) {
		super.awakeWithContext(context)
		
		var pickerItems: [WKPickerItem] = []
		
		for i in 1...10 {
			let item = WKPickerItem()
			item.title = "Picker item \(i)"
			pickerItems.append(item)
		}
		
		self.pickerOutlet.setItems(pickerItems)
	}
	
	override func willActivate() {
		// This method is called when watch view controller is about to be visible to user
		super.willActivate()
	}
	
	override func didDeactivate() {
		// This method is called when watch view controller is no longer visible
		super.didDeactivate()
	}
	
}
