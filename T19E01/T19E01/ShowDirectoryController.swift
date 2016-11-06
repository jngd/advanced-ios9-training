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

class ShowDirectoryController: UITableViewController {
	
	/***** Vars *****/
	var files = [String]()
	var fileManager: NSFileManager!
	var documentsPath: String!
	var fileList = [String]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		fileManager = NSFileManager.defaultManager()
		
		documentsPath = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,
			NSSearchPathDomainMask.UserDomainMask, true).first! as String)
		
		do{
			fileList = try fileManager.contentsOfDirectoryAtPath(documentsPath)
		}catch{
			print("Error getting file structure.")
		}
	}
	
	override func viewDidAppear(animated: Bool) {
		
		do{
			files = try fileManager.contentsOfDirectoryAtPath(documentsPath)
		}catch{
			print("Error getting file structure")
		}
		tableView.reloadData()
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as! FileExplorerCell
		let path = files[indexPath.row]
		var isDir: ObjCBool = ObjCBool(false)
		
		if (!fileManager.fileExistsAtPath((documentsPath as
			NSString).stringByAppendingPathComponent(path), isDirectory: &isDir)){
			print("File not exists")
			return cell;
		}
		
		if (isDir.boolValue) {
			cell.elementIcon?.image = UIImage(named: "dir.jpg")
		} else {
			cell.elementIcon?.image = UIImage(named: "file.png")
		}
		
		cell.name.text = path
		
		return cell
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return files.count
	}
}