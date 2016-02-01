//
//  SearchViewController.swift
//  TPD Compare
//
//  Created by STG Connect on 26/01/16.
//  Copyright © 2016 Scandinavian Tobacco Group. All rights reserved.
//

import UIKit
import Parse

class SearchViewController: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: Attributes

    @IBOutlet weak var SearchTextField: UITextField!
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ActivityIndicatorView: UIView!
    @IBOutlet weak var BrandCollectionView: UICollectionView!
    
    var market:String? = ""
    var eanCode:String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SearchTextField.delegate = self
        
        self.BrandCollectionView.delegate = self
        self.BrandCollectionView.dataSource = self
        
        retrieveBestBrands(market!)

        // Add notification listeners
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "searchProductsRetrieved:", name:"searchProductsRetrieved", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "bestBrandsRetrieved:", name:"bestBrandsRetrieved", object: nil)
    
    }
    
    func showIndicator(){
        UIView.animateWithDuration(0.5, animations: {
            self.ActivityIndicatorView.alpha = 1
        })
    }
    
    func hideIndicator(){
        UIView.animateWithDuration(0.5, animations: {
            self.ActivityIndicatorView.alpha = 0
        })
    }
    
    func showNoResults(){
        UIView.animateWithDuration(0.5, animations: {
            self.ErrorLabel.alpha = 1
        })
    }
    
    func hideNoResults(){
        UIView.animateWithDuration(0.5, animations: {
            self.ErrorLabel.alpha = 0
        })
    }
    
    func searchProductsRetrieved(notification:NSNotification){
        if (products.count == 1) {
            performSegueWithIdentifier("SearchToResult", sender: nil)
        } else if (products.count == 0) {
            showNoResults()
        }
        hideIndicator()
    }
    
    func bestBrandsRetrieved(notification:NSNotification){
        bestBrands.sortInPlace {$0.order < $1.order}
        self.BrandCollectionView.reloadData()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier ==  "SearchToResult"){
            let dvc = segue.destinationViewController as! ResultViewController
            dvc.productsArray = products
        } else if (segue.identifier == "showScan"){
            let dvc = segue.destinationViewController as! ScanViewController
            dvc.market = market!
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        hideNoResults()
    }
    
    // MARK: Text Field Delegate Methods
    func textFieldDidEndEditing(textField: UITextField) {
        eanCode = SearchTextField.text
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: customCollectionCell = BrandCollectionView.dequeueReusableCellWithReuseIdentifier("BestBrandCollectionCell", forIndexPath: indexPath) as! customCollectionCell
        
        cell.collectionImage.image = bestBrands[indexPath.row].image
        cell.collectionLabel.text = bestBrands[indexPath.row].brand
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bestBrands.count
    }
    
    
    // MARK: Actions
    @IBAction func SearchButton(sender: UIButton) {
        if (self.SearchTextField.text != ""){
            hideNoResults()
            eanCode = SearchTextField.text
            SearchTextField.endEditing(true)
            retrieveProducts(eanCode, market: market!, target: "search")
            showIndicator()
        }
    }
    
    @IBAction func ScanButton(sender: UIButton) {
        performSegueWithIdentifier("showScan", sender: nil)
    }
    
    @IBAction func returnToSearchView(sender:UIStoryboardSegue) {
        segueTrigger=0
    }
}
