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

@objc(SizeTableViewControllerDelegate)
protocol SizeTableViewControllerDelegate {
	optional func sizeSelection(sender: SizeTableViewController,
	                            selectedValue: String)
}

class SizeTableViewController: UITableViewController {
	
	var sizes = ["Little", "Medium", "Big"]
	let tableviewCellIdentifier = "sizeSelectionCell"
	var selectedSize = "Medium"
	var delegate: SizeTableViewControllerDelegate?

	required override init(style: UITableViewStyle) {
		super.init(style: style)
		tableView.registerClass(UITableViewCell.classForCoder(),
		                        forCellReuseIdentifier: tableviewCellIdentifier)
		title = "Pick a size"
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection
		section: Int) -> Int {
		return 3
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath
		indexPath: NSIndexPath) -> UITableViewCell {
		let cell =
			tableView.dequeueReusableCellWithIdentifier(tableviewCellIdentifier,
			                                            forIndexPath: indexPath)
		cell.textLabel?.text = self.sizes[indexPath.row]
		return cell
	}

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath
		indexPath: NSIndexPath) {
		if let theDelegate = delegate {
			selectedSize = self.sizes[indexPath.row]
			theDelegate.sizeSelection!(self, selectedValue: selectedSize)
		}
	}
}