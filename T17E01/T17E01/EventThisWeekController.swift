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
import EventKit

class EventThisWeekController: UITableViewController {
	
	var eventStore: EKEventStore = EKEventStore()
	var eventsThisWeek: [EKEvent] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.eventStore.requestAccessToEntityType(.Event) {
			(granted, error) -> Void in
			
			guard granted else { fatalError("Permission denied") }
			
			let endDate = NSDate(timeIntervalSinceNow: 604800)
			let predicate = self.eventStore.predicateForEventsWithStartDate(NSDate(),
			                                                                endDate: endDate,
			                                                                calendars: nil)
			self.eventsThisWeek = self.eventStore.eventsMatchingPredicate(predicate)
			print(self.eventsThisWeek.count)
			
			dispatch_async(dispatch_get_main_queue(), { () -> Void in
				self.tableView.reloadData()
			})
		}
		
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		print("cellForRowAtIndexPath")
		let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
		
		cell.textLabel?.text = self.eventsThisWeek[indexPath.row].title
		
		return cell
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print("numberOfRowsInSection")
		return eventsThisWeek.count
	}
}

// :]