/**
* Copyright (c) 2016 Juan Garcia
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {
	
	var sizeConfigurationItem: SLComposeSheetConfigurationItem{
		let item = SLComposeSheetConfigurationItem()
		item.title = "Tamaño"
		item.value = self.selectedSize
		item.tapHandler = self.showSizeSelection
		return item
	}
	
	override func isContentValid() -> Bool {
		return true
	}
	
	override func didSelectPost() {
		self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
	}
	
	override func configurationItems() -> [AnyObject]! {
		return [sizeConfigurationItem]
	}

	func showSizeSelection(){
		let controller = SizeTableViewController(style: .Plain)
		controller.selectedSize = self.sizeConfigurationItem.value
		controller.delegate = self
		pushConfigurationViewController(controller)
	}	
}
