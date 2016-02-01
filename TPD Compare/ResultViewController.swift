//
//  CompareViewController.swift
//  TPD Compare
//
//  Created by STG Connect on 22/01/16.
//  Copyright © 2016 Scandinavian Tobacco Group. All rights reserved.
//

import UIKit
import Parse

class ResultViewController: UIViewController, UITextFieldDelegate {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eanOld.text = productsArray[0].eanOld
        self.eanNew.text = productsArray[0].eanNew
        self.nameOld.text = productsArray[0].nameOld
        self.nameNew.text = productsArray[0].nameNew
        self.packGroupOld.text = productsArray[0].packGroupOld
        self.packGroupNew.text = productsArray[0].packGroupNew
        self.marketValue.text = productsArray[0].marketValue
        self.categoryValue.text = productsArray[0].categoryValue
        self.widthValue.text = productsArray[0].widthValue
        self.heightValue.text = productsArray[0].heightValue
        self.depthValue.text = productsArray[0].depthValue
        self.taraWeight.text = productsArray[0].taraWeight
        self.netWeight.text = productsArray[0].netWeight
        self.packSizeOld.text = productsArray[0].packSizeOld
        self.packSizeNew.text = productsArray[0].packSizeNew

    }

}
