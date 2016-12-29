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

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBOutlet weak var imageView: UIImageView!

	@IBAction func takePhoto(sender: AnyObject) {

		guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) else {
			print("Cannot access to camera")
			return
		}

		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
		imagePicker.allowsEditing = false
		self.presentViewController(imagePicker, animated: true, completion: nil)
	}

	@IBAction func pickPhoto(sender: AnyObject) {

		guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) else {
			print("Cannot access to photo library")
			return
		}

		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
		imagePicker.allowsEditing = true
		self.presentViewController(imagePicker, animated: true, completion: nil)
	}

	@IBAction func sendAction(sender: AnyObject) {
		let controller = UIActivityViewController(activityItems: [self.imageView.image!],applicationActivities: nil)
		self.presentViewController(controller, animated: true, completion: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		imageView.image = UIImage(named: "elhobbit.jpg")
	}

	func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
		imageView.image = image
		self.dismissViewControllerAnimated(true, completion: nil);
	}
}
