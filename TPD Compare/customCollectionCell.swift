//
//  customCollectionCell.swift
//  TPD Compare
//
//  Created by STG Connect on 29/01/16.
//  Copyright © 2016 Scandinavian Tobacco Group. All rights reserved.
//

import Foundation
import UIKit

class customCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionImage: UIImageView!
    @IBOutlet weak var collectionLabel: UILabel!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1

    }
    
}
