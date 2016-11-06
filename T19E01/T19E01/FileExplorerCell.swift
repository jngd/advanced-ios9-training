//
//  FileExplorerCell.swift
//  T19E01
//
//  Created by jngd on 06/11/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit

class FileExplorerCell: UITableViewCell {

	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var elementIcon: UIImageView!

	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
}
