//
//  companies.swift
//  TPD Compare
//
//  Created by STG Connect on 26/01/16.
//  Copyright © 2016 Scandinavian Tobacco Group. All rights reserved.
//

import Foundation
import UIKit
import Parse

var companies = [company]()

class company {
    var name = ""
    var value = ""
    init(name:String,value:String){
        self.name = name
        self.value = value
    }
}

func retrieveCompanies() {
    let query = PFQuery(className:"Companies")
    query.addAscendingOrder("Name")
    query.findObjectsInBackgroundWithBlock {
        (objects: [PFObject]?, error: NSError?) -> Void in
        if error == nil {
            companies = []
            print("Successfully retrieved \(objects!.count) companies.")
            for object in objects! {
                let companyName:String? = (object as PFObject)["Name"] as? String
                let companyValue:String? = (object as PFObject)["Value"] as? String
                let fullCompany = company(name: companyName!, value: companyValue!)
                companies.append(fullCompany)
            }
            NSNotificationCenter.defaultCenter().postNotificationName("companiesRetrieved", object: nil)
        }
    }
    
}