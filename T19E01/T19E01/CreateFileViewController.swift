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

class CreateFileViewController: UIViewController {
	
	/***** Vars *****/
	var fileManager = NSFileManager.defaultManager()
	var documentsPath = (NSSearchPathForDirectoriesInDomains(
		NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first! as NSString)

	/***** Outlets *****/
	@IBOutlet weak var fileName: UITextField!
	@IBOutlet weak var fileContent: UITextField!
	@IBOutlet weak var dirName: UITextField!

	/***** Actions *****/
	@IBAction func generateFile(sender: AnyObject) {
		let content = fileContent.text?.dataUsingEncoding(NSUTF8StringEncoding)
		
		if fileManager.createFileAtPath(documentsPath.stringByAppendingPathComponent(
			"\(fileName.text!).txt"), contents: content, attributes: nil) {
			print("File saved")
		} else {
			print("Error saving file")
		}
		
	}
	
	@IBAction func generateDirectory(sender: AnyObject) {
		let newDirectory = documentsPath.stringByAppendingPathComponent(dirName.text!)
		
		do {
			try fileManager.createDirectoryAtPath(newDirectory,
			                                      withIntermediateDirectories: true,
			                                      attributes: nil)
			
			print("Directory created")
		} catch {
			print("Error creating directory")
		}
		
	}
	
}