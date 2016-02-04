//
//  customTableCell.swift
//  TPD Compare
//
//  Created by STG Connect on 04/02/16.
//  Copyright © 2016 Scandinavian Tobacco Group. All rights reserved.
//

import Foundation
import UIKit

class customTableCell: UITableViewCell {
    
    @IBOutlet weak var LabelNameOld: UILabel!
    @IBOutlet weak var LabelNameNew: UILabel!
    @IBOutlet weak var LabelEanOld: UILabel!
    @IBOutlet weak var LabelEanNew: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
