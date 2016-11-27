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
import CoreSpotlight
import MobileCoreServices

class RecipeViewController: UIViewController {
	
	@IBOutlet weak var recipeImage: UIImageView?
	@IBOutlet weak var recipeName: UILabel?
	@IBOutlet weak var recipeDescription: UITextView?

	var recipeImageURL: String!
	var recipeNameText: String!
	var recipeDescriptionText: String!

	override func viewDidLoad() {
		super.viewDidLoad()

		recipeImage?.image = UIImage(named: recipeImageURL)
		recipeName?.text = recipeNameText
		recipeDescription?.text = recipeDescriptionText

		let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeImage as String)
		attributeSet.title = recipeNameText
		attributeSet.contentDescription = recipeDescriptionText

		let item = CSSearchableItem(uniqueIdentifier: "1",
		                            domainIdentifier: "album-1", attributeSet: attributeSet)


		CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([item]) {
			(error) -> Void in
			if error != nil {
				print (error?.localizedDescription)
			} else {
				print ("Element indexed")
			}
		}
	}
}
