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

struct Movie {
	let name: String
	let director: String
	let year: Int
	let image: String
}

class ViewController: UIViewController {
	
	/***** Outlets *****/
	@IBOutlet weak var table: UITableView!
	
	/***** Vars *****/
	var movies: [Movie] = []
	override func viewDidLoad() {
		super.viewDidLoad()
		loadMovies()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	func loadMovies(){
		movies = [Movie]()
		
		let db_path = NSBundle.mainBundle().pathForResource("db/peliculas", ofType:
			"sqlite")
		
		var db: COpaquePointer = nil
		
		let status = sqlite3_open(db_path!, &db)
		
		if status != SQLITE_OK {
			print("Error at open DB")
			return
		}
		
		let query_stmt = "SELECT * FROM peliculas"
		var statement: COpaquePointer = nil
		
		if(sqlite3_prepare_v2(db, query_stmt, -1, &statement, nil) !=
			SQLITE_OK){
			print("Error in prepare")
			return
		}
		
		while(sqlite3_step(statement) == SQLITE_ROW){
			let nameMem = sqlite3_column_text(statement, 1)
			let name = String.fromCString(UnsafePointer<CChar>(nameMem))
			let directorMem = sqlite3_column_text(statement, 2)
			let director =
				String.fromCString(UnsafePointer<CChar>(directorMem))
			let year = sqlite3_column_int(statement, 3)
			let imagenMem = sqlite3_column_text(statement, 4)
			let imagen =
				String.fromCString(UnsafePointer<CChar>(imagenMem))
			let movie = Movie(name: name!, director: director!,
			                  year: Int(year), image: imagen!)
			movies.append(movie)
		}
		
		sqlite3_finalize(statement)
		
		self.table.reloadData()
	}
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as! MovieCell
		
		cell.title.text = movies[indexPath.item].name
		cell.year.text = String(movies[indexPath.item].year)
		cell.director.text = movies[indexPath.item].director
		
		return cell
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return movies.count
	}
}

