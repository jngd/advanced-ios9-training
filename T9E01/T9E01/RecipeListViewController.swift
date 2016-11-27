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

class RecipeListViewController: UIViewController {

	var cells: NSArray?

	override func viewDidLoad() {
		super.viewDidLoad()
		let path = NSBundle.mainBundle().bundlePath as NSString
		let finalPath = path.stringByAppendingPathComponent("recetas.plist")
		cells = NSArray(contentsOfFile: finalPath)
	}
}

extension RecipeListViewController: UITableViewDataSource {

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (cells?.count)!
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("Recipe", forIndexPath: indexPath) as! RecipeListCell

		let recipeName = ((self.cells![indexPath.row] as AnyObject?)!.objectForKey("nombre") as? String)!
		let recipeImageName = ((self.cells![indexPath.row] as AnyObject?)!.objectForKey("imagen") as? String)!
		let recipeImage: UIImage = UIImage(named: recipeImageName)!
		let recipeDescription = ((self.cells![indexPath.row] as AnyObject?)!.objectForKey("descripcion") as? String)!

		cell.recipeName?.text = recipeName
		cell.recipeImage?.image = recipeImage
		cell.recipeDescription = recipeDescription

		return cell
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "ViewRecipeDetail",
			let cell = sender as! RecipeListCell? {
			guard let recipeViewController = segue.destinationViewController as? RecipeViewController else {
				return
			}

			recipeViewController.recipeImageURL = cell.recipeImage.image?.accessibilityIdentifier
			recipeViewController.recipeNameText = cell.recipeName.text
			recipeViewController.recipeDescriptionText = cell.recipeDescription
		}
	}
}

extension RecipeListViewController: UITableViewDelegate {

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
	}
}