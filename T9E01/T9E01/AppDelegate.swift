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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: ([AnyObject]?) -> Void) -> Bool {

		print(userActivity.contentAttributeSet?.title) //nil
		print(userActivity.eligibleForSearch)
		let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

		let initialViewController : UINavigationController = mainStoryboardIpad.instantiateViewControllerWithIdentifier("MainViewController") as! UINavigationController

		self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
		self.window?.rootViewController = initialViewController
		self.window?.makeKeyAndVisible()

//		let viewController = self.window?.rootViewController!.storyboard?.instantiateViewControllerWithIdentifier("RecipeViewController") as! RecipeViewController
//
//		viewController.recipeImageURL = celda["imagen"] as? String
//		viewController.recipeNameText = celda["nombre"] as? String
//		viewController.recipeDescriptionText = celda["descripcion"] as? String
//		initialViewController.pushViewController(viewController, animated: true)

		return true
	}
}

