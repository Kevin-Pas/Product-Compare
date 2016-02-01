//
//  brands.swift
//  TPD Compare
//
//  Created by STG Connect on 28/01/16.
//  Copyright © 2016 Scandinavian Tobacco Group. All rights reserved.
//

import Foundation
import UIKit
import Parse


var bestBrands = [bestBrand]()

class bestBrand {
    var brand = ""
    var market = ""
    var order:Int = 0
    var image:UIImage?
    init(brand:String,market:String,order:Int,image:UIImage) {
        self.brand = brand
        self.market = market
        self.order = order
        self.image = image
    }
}


func retrieveBestBrands(market:String){
    let query:PFQuery = PFQuery(className:"BestBrands")
    query.whereKey("Market", equalTo: market)
    query.orderByAscending("Order")
    query.limit = 6
    query.findObjectsInBackgroundWithBlock {
        (objects: [PFObject]?, error: NSError?) -> Void in
        
        if error  == nil {
            // Clear the bestBrands
            bestBrands = []
            print("Successfully retrieved \(objects!.count) brands.")

            // Loop through the objects array
            for object in objects! {
                let brand:String? = (object as PFObject)["Brand"] as? String
                let market:String? = (object as PFObject)["Market"] as? String
                let order:Int! = (object as PFObject)["Order"] as? Int
                //let userImageFile = (object as PFObject)["Image"] as! PFFile
                var image = UIImage()
                let ImageFile = object["Image"] as? PFFile
                if (ImageFile != nil) {
                    ImageFile?.getDataInBackgroundWithBlock{ (imageData: NSData?, error: NSError?) -> Void in
                        if (error == nil) {
                            image = UIImage(data: imageData!)!
                            let item = bestBrand(brand: brand!, market: market!, order: order,image: image)
                            bestBrands.append(item)
                        }
                        NSNotificationCenter.defaultCenter().postNotificationName("bestBrandsRetrieved", object: nil)

                    }
                } else {
                    let item = bestBrand(brand: brand!, market: market!, order: order,image: image)
                    bestBrands.append(item)
                }
            }
        }
    }

}