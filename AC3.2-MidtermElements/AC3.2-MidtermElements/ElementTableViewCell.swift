//
//  ElementTableViewCell.swift
//  AC3.2-MidtermElements
//
//  Created by Ana Ma on 12/15/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class ElementTableViewCell: UITableViewCell {

    @IBOutlet weak var elementImageView: UIImageView!
    @IBOutlet weak var elementTitleLabel: UILabel!
    @IBOutlet weak var elementDetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
