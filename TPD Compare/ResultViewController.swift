//
//  CompareViewController.swift
//  TPD Compare
//
//  Created by STG Connect on 22/01/16.
//  Copyright © 2016 Scandinavian Tobacco Group. All rights reserved.
//

import UIKit
import Parse

class ResultViewController: UIViewController {

    @IBOutlet weak var eanOld: UILabel!
    @IBOutlet weak var eanNew: UILabel!
    @IBOutlet weak var nameOld: UILabel!
    @IBOutlet weak var nameNew: UILabel!
    @IBOutlet weak var packGroupOld: UILabel!
    @IBOutlet weak var packGroupNew: UILabel!
    @IBOutlet weak var marketValue: UILabel!
    @IBOutlet weak var categoryValue: UILabel!
    @IBOutlet weak var widthValue: UILabel!
    @IBOutlet weak var heightValue: UILabel!
    @IBOutlet weak var depthValue: UILabel!
    @IBOutlet weak var taraWeight: UILabel!
    @IBOutlet weak var netWeight: UILabel!
    @IBOutlet weak var packSizeOld: UILabel!
    @IBOutlet weak var packSizeNew: UILabel!
    
    var productsArray = [product]()
    var productArray: product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let product = productArray {
            self.eanOld.text = product.eanOld
            self.eanNew.text = product.eanNew
            self.nameOld.text = product.nameOld
            self.nameNew.text = product.nameNew
            self.packGroupOld.text = product.packGroupOld
            self.packGroupNew.text = product.packGroupNew
            self.marketValue.text = product.marketValue
            self.categoryValue.text = product.categoryValue
            self.widthValue.text = product.widthValue
            self.heightValue.text = product.heightValue
            self.depthValue.text = product.depthValue
            self.taraWeight.text = product.taraWeight
            self.netWeight.text = product.netWeight
            self.packSizeOld.text = product.packSizeOld
            self.packSizeNew.text = product.packSizeNew
        }
    }

    
}
