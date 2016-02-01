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
    
    init?(eanNew:String,nameOld:String, nameNew:String,packGroupOld:String,packGroupNew:String,marketValue:String,categoryValue:String,widthValue:String,heightValue:String,depthValue:String,taraWeight:String,netWeight:String,packSizeOld:String,packSizeNew:String){
        self.eanNew = eanNew
        self.nameOld = nameOld
        self.nameNew = nameNew
        self.packGroupOld = packGroupOld
        self.packGroupNew = packGroupNew
        self.marketValue = marketValue
        self.categoryValue = categoryValue
        self.widthValue = String(widthValue)
        self.heightValue = String(heightValue)
        self.depthValue = String(depthValue)
        self.taraWeight = String(taraWeight)
        self.netWeight = String(netWeight)
        self.packSizeOld = String(packSizeOld)
        self.packSizeNew = String(packSizeNew)

    }
}

func retrieveProducts(EAN:String, eanType:String, market:String, target:String) {
    if EAN != "" {
        let query = PFQuery(className:"TPDCompare")
        query.whereKey("EanOld", equalTo:EAN)
        query.whereKey("EanNew", equalTo:EAN)
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
                        let eanNew:String? = (object as PFObject)["EanNew"] as? String
                        let nameOld:String? = (object as PFObject)["NameOld"] as? String
                        let nameNew:String? = (object as PFObject)["NameNew"] as? String
                        let packGroupOld:String? = (object as PFObject)["PackGroupOld"] as? String
                        let packGroupNew:String? = (object as PFObject)["PackGroupNew"] as? String
                        let marketValue:String? = (object as PFObject)["Market"] as? String
                        let categoryValue:String? = (object as PFObject)["Category"] as? String
                        let widthValue:Int! = (object as PFObject)["Width"] as? Int
                        let heightValue:Int! = (object as PFObject)["Height"] as? Int
                        let depthValue:Int! = (object as PFObject)["Depth"] as? Int
                        let taraWeight:Int! = (object as PFObject)["TaraWeight"] as? Int
                        let netWeight:Int! = (object as PFObject)["NetWeight"] as? Int
                        let packSizeOld:Int! = (object as PFObject)["PackSizeOld"] as? Int
                        let packSizeNew:Int! = (object as PFObject)["PackSizeNew"] as? Int
                        let fullProduct = product(eanNew: eanNew!,
                            nameOld: nameOld!,
                            nameNew:nameNew!,
                            packGroupOld:packGroupOld!,
                            packGroupNew:packGroupNew!,
                            marketValue:marketValue!,
                            categoryValue:categoryValue!,
                            widthValue:String(widthValue),
                            heightValue:String(heightValue),
                            depthValue:String(depthValue),
                            taraWeight:String(taraWeight),
                            netWeight:String(netWeight),
                            packSizeOld:String(packSizeOld),
                            packSizeNew:String(packSizeNew))
                        products.append(fullProduct!)
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
