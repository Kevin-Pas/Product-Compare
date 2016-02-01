//
//  WelcomeViewController.swift
//  TPD Compare
//
//  Created by STG Connect on 26/01/16.
//  Copyright © 2016 Scandinavian Tobacco Group. All rights reserved.
//

import UIKit
import Parse

class WelcomeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {

    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var CompanyPicker: UIPickerView!
    
    var market:String? = ""
    let defaults = NSUserDefaults.standardUserDefaults()
    var pickerIndex:Int = 0
    var customIndex:Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        CompanyPicker.dataSource = self
        CompanyPicker.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "companiesRetrieved:", name:"companiesRetrieved", object: nil)
        
        retrieveCompanies()
    }

    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return companies.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return companies[row].name
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        market = companies[row].value
        pickerIndex = CompanyPicker.selectedRowInComponent(0)
        defaults.setObject(pickerIndex, forKey: "marketStored")
    }
    
    func companiesRetrieved(notification:NSNotification) {
        let pickerIndexString = defaults.stringForKey("marketStored")
        if pickerIndexString != nil {
            pickerIndex = Int(pickerIndexString!)!
        }
        self.CompanyPicker.reloadAllComponents()
        CompanyPicker.selectRow(pickerIndex, inComponent: 0, animated: true)
        market = companies[pickerIndex].value
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showSearch"){
            let dvc = segue.destinationViewController as! SearchViewController
            dvc.market = market
        }
    }

}
