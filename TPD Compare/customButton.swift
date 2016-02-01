//
//  customButton.swift
//  TPD Compare
//
//  Created by STG Connect on 26/01/16.
//  Copyright © 2016 Scandinavian Tobacco Group. All rights reserved.
//

import UIKit

class customButton: UIButton {
    
    override func awakeFromNib(){
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0).CGColor
        self.titleEdgeInsets = UIEdgeInsetsMake(0,0,0,0)
        self.contentEdgeInsets = UIEdgeInsetsMake(5,10,5,10)
        self.setTitleColor(UIColor(red: 64/255, green: 55/255, blue: 51/255, alpha: 1), forState: .Normal)
        self.titleLabel!.font = UIFont(name: "System-thin", size: 25)
    }
}