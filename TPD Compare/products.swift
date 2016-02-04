//
//  products.swift
//  TPD Compare
//
//  Created by STG Connect on 27/01/16.
//  Copyright © 2016 Scandinavian Tobacco Group. All rights reserved.
//

import Foundation
import UIKit
import Parse

var products = [product]()

class product {
    
    let eanOld:String
    let eanNew:String
    let nameOld:String
    let nameNew:String
    let packGroupOld:String
    let packGroupNew:String
    let marketValue:String
    let categoryValue:String
    let widthValue:String
    let heightValue:String
    let depthValue:String
    let taraWeight:String
    let netWeight:String
    let packSizeOld:String
    let packSizeNew:String
    
    init?(eanOld:String, eanNew:String,nameOld:String, nameNew:String,packGroupOld:String,packGroupNew:String,marketValue:String,categoryValue:String,widthValue:String,heightValue:String,depthValue:String,taraWeight:String,netWeight:String,packSizeOld:String,packSizeNew:String){
        self.eanOld = eanOld
        self.eanNew = eanNew
        self.nameOld = nameOld
        self.nameNew = nameNew
        self.packGroupOld = packGroupOld
        self.packGroupNew = packGroupNew
        self.marketValue = marketValue
        self.categoryValue = categoryValue
        self.widthValue = widthValue
        self.heightValue = heightValue
        self.depthValue = depthValue
        self.taraWeight = taraWeight
        self.netWeight = netWeight
        self.packSizeOld = packSizeOld
        self.packSizeNew = packSizeNew
    }
}

func retrieveProducts(EAN:String, market:String, target:String) {
    if EAN != "" {
        let eanOldQuery = PFQuery(className: "TPDCompare")
        eanOldQuery.whereKey("EanOld", equalTo: EAN)
        
        let eanNewQuery = PFQuery(className: "TPDCompare")
        eanNewQuery.whereKey("EanNew", equalTo: EAN)
        
        let nameOldQuery = PFQuery(className: "TPDCompare")
        nameOldQuery.whereKey("SearchNameOld", containsString: EAN.lowercaseString)
        
        let nameNewQuery = PFQuery(className: "TPDCompare")
        nameNewQuery.whereKey("SearchNameNew", containsString: EAN.lowercaseString)
        
        let query = PFQuery.orQueryWithSubqueries([eanOldQuery,eanNewQuery,nameOldQuery,nameNewQuery])
        query.whereKey("Market", equalTo:market)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) products.")
                // Do something with the found objects
                products = []
                if let objects = objects {
                    for object in objects {
                        print(object.objectId)
                        let eanOld:String! = (object as PFObject)["EanOld"] as? String
                        print(eanOld)
                        let eanNew:String! = (object as PFObject)["EanNew"] as? String
                        let nameOld:String? = (object as PFObject)["NameOld"] as? String
                        let nameNew:String? = (object as PFObject)["NameNew"] as? String
                        let packGroupOld:String? = (object as PFObject)["PackGroupOld"] as? String
                        let packGroupNew:String? = (object as PFObject)["PackGroupNew"] as? String
                        let marketValue:String? = (object as PFObject)["Market"] as? String
                        let categoryValue:String? = (object as PFObject)["Category"] as? String
                        let widthValue:String! = (object as PFObject)["Width"] as? String
                        let heightValue:String! = (object as PFObject)["Height"] as? String
                        let depthValue:String! = (object as PFObject)["Depth"] as? String
                        let taraWeight:String! = (object as PFObject)["TaraWeight"] as? String
                        let netWeight:String! = (object as PFObject)["NetWeight"] as? String
                        let packSizeOld:String! = (object as PFObject)["PackSizeOld"] as? String
                        let packSizeNew:String! = (object as PFObject)["PackSizeNew"] as? String
                        let fullProduct = product(eanOld: eanOld!,
                            eanNew: eanNew!,
                            nameOld: nameOld!,
                            nameNew:nameNew!,
                            packGroupOld:packGroupOld!,
                            packGroupNew:packGroupNew!,
                            marketValue:marketValue!,
                            categoryValue:categoryValue!,
                            widthValue:widthValue!,
                            heightValue:heightValue!,
                            depthValue:depthValue!,
                            taraWeight:taraWeight!,
                            netWeight:netWeight!,
                            packSizeOld:packSizeOld!,
                            packSizeNew:packSizeNew!)
                        products.append(fullProduct!)
                        print(fullProduct!.eanOld)
                    }
                    if (target == "search"){
                    NSNotificationCenter.defaultCenter().postNotificationName("searchProductsRetrieved", object: nil)
                    } else if (target == "scan") {
                    NSNotificationCenter.defaultCenter().postNotificationName("scanProductsRetrieved", object: nil)
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
}
