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
import CoreData

class ViewController: UIViewController {

	var appDel: AppDelegate!
	var context: NSManagedObjectContext!
	var request: NSFetchRequest!
	var results = [NSManagedObject]()

	@IBOutlet weak var tableView: UITableView!

	override func viewDidLoad() {
		super.viewDidLoad()
		appDel = UIApplication.sharedApplication().delegate as! AppDelegate
		context = appDel.managedObjectContext

		let film = NSEntityDescription.insertNewObjectForEntityForName("Film", inManagedObjectContext: context) as NSManagedObject

		// TODO : Insert films here
		film.setValue("Godzilla", forKey: "title")
		film.setValue(2014, forKey: "year")
		film.setValue("Gareth Edwards", forKey: "director")
		film.setValue("godzilla.jpg", forKey: "filmPoster")

		do{
			try context.save()
		}catch{
			print("Data saving failed")
		}

		loadTable()
	}

	func loadTable() {
		let request = NSFetchRequest(entityName: "Film")

		request.returnsObjectsAsFaults = false

		do{
			results = try context.executeFetchRequest(request) as! [NSManagedObject]
		}catch{
			print("Error getting values for films")
		}
	}

}

extension ViewController: UITableViewDataSource {

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return results.count
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCellWithIdentifier("MyTableViewCell") as! MyTableViewCell

		let film = results[indexPath.item]
		cell.title.text = film.valueForKey("title") as? String
		cell.director.text = film.valueForKey("director") as? String
		cell.year.text = String(film.valueForKey("year") as! NSNumber)
		
		let imageFromPath = UIImage(contentsOfFile: (film.valueForKey("filmPoster") as? String)!)
		cell.imageView?.image = imageFromPath

		return cell
	}

	func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return true
	}

	func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

		guard editingStyle == .Delete else {
			return
		}

		context.deleteObject(results[indexPath.item])

		do {
			try self.context.save()
			self.results.removeAtIndex(indexPath.row)
			self.tableView.reloadData()
		}catch{
			print("error deleting element")
		}
	}

}

extension ViewController: UITableViewDelegate {
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
	}
}
