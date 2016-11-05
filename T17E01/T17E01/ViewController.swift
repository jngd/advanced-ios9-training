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

class ViewController: UIViewController {
	
	/***** Outlets *****/
	@IBOutlet weak var calendarNameTextField: UITextField!
	@IBOutlet weak var datePicker: UIDatePicker!
	@IBOutlet weak var eventTextField: UITextField!
	@IBOutlet weak var titleTextField: UITextField!
	
	/***** Vars *****/
	var eventStore: EKEventStore!
	var calendar: EKCalendar!
	
	/***** Actions *****/
	@IBAction func saveEvent(sender: AnyObject) {
		self.eventStore.requestAccessToEntityType(.Event) {
			(granted, error) -> Void in
			
			guard granted else { fatalError("Permission denied") }
			
			let calendar = self.eventStore.calendarWithIdentifier(
				NSUserDefaults.standardUserDefaults().objectForKey("calendarIdentifier") as! String)
			
			guard calendar != nil else { fatalError("Calendar not valid") }
			
			let event = EKEvent(eventStore: self.eventStore)
			event.title = self.eventTextField.text!
			event.startDate = self.datePicker.date
			event.endDate =
				self.datePicker.date.dateByAddingTimeInterval(60*60)
			event.calendar = calendar!
			
			do{
				try self.eventStore.saveEvent(event, span: .ThisEvent)
				
				let alerta = UIAlertController(title: "Calendar",
				                               message: "Event created \(event.title) in \(calendar!.title)",
				                               preferredStyle: .Alert)
				
				alerta.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
				
				NSOperationQueue.mainQueue().addOperationWithBlock(){
					self.presentViewController(alerta, animated: true,
						completion: nil)
				}
				
			}catch let error as NSError{
				print("An errors occurs saving event \(error.localizedDescription)")
			}
		}
	}
	
	@IBAction func saveCalendar(sender: AnyObject) {
		
		self.eventStore.requestAccessToEntityType(.Event) {
			(granted, error) -> Void in
			
			guard granted else { fatalError("Permission denied") }
			
			let name = self.calendarNameTextField.text
			
			let aux = self.eventStore.sources
			let calendar = EKCalendar(forEntityType: .Event, eventStore: self.eventStore)
			
			calendar.source = aux[0]
			calendar.title = name!
			
			print(calendar.calendarIdentifier)
			
			do {
				try self.eventStore.saveCalendar(calendar, commit: true)
				
				NSUserDefaults.standardUserDefaults().setObject(calendar.calendarIdentifier,
				                                                forKey: "calendarIdentifier")
				
			} catch let error as NSError {
				print("Error saving calendar: \(error.localizedDescription)")
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		eventStore = EKEventStore()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
}

// :]