//
//  ChecklistVCCell.swift
//  tableView
//
//  Created by abdulrahman on 4/16/20.
//  Copyright © 2020 abdulrahmanAbdou. All rights reserved.
//

import UIKit

class ChecklistVCCell: UITableViewCell {

    
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var checkLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
