//
//  BrandDetailViewController.swift
//  TPD Compare
//
//  Created by STG Connect on 01/02/16.
//  Copyright © 2016 Scandinavian Tobacco Group. All rights reserved.
//

import UIKit

class BrandDetailViewController: UIViewController {

    var brands:bestBrand?
    
    @IBOutlet weak var brandLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let brand = brands {
            brandLabel.text = brand.brand
        }
    }

    
    

}
