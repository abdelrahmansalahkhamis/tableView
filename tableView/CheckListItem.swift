//
//  CheckListItem.swift
//  tableView
//
//  Created by abdulrahman on 4/12/20.
//  Copyright © 2020 abdulrahmanAbdou. All rights reserved.
//

import Foundation


class CheckListItem: NSObject {    // to be able to compare my item with other items without writing my own code
    
    
    @objc var text: String = ""
    var checked = false
    
    func toggleChecked(){
        checked = !checked
    }
}
