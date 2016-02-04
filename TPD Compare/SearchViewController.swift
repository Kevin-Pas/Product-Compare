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
    @IBOutlet weak var ActivityIndicatorViewHeight: NSLayoutConstraint!
    @IBOutlet weak var SearchingLabel: UILabel!
    
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
    
    func showSearching(){
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.2, animations: {
            self.ActivityIndicatorViewHeight.constant = 24
            self.SearchingLabel.alpha = 1
            self.ActivityIndicator.alpha = 1
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func hideSearching(){
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.2, animations: {
            self.ActivityIndicatorViewHeight.constant = 0
            self.SearchingLabel.alpha = 0
            self.ActivityIndicator.alpha = 0
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func showNoResults(text:String){
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.2, animations: {
            self.ActivityIndicatorViewHeight.constant = 24
            self.ErrorLabel.alpha = 1
            self.ErrorLabel.text = text
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func hideNoResults(){
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.2, animations: {
            self.ActivityIndicatorViewHeight.constant = 0
            self.ErrorLabel.alpha = 0
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func searchProductsRetrieved(notification:NSNotification){
        hideSearching()
        if (products.count == 1) {
            performSegueWithIdentifier("SearchToResultDetail", sender: nil)
        }  else if (products.count > 1) {
            performSegueWithIdentifier("SearchToResult", sender: nil)
        } else if (products.count == 0) {
            showNoResults("No results found")
        }
    }
    
    func bestBrandsRetrieved(notification:NSNotification){
        bestBrands.sortInPlace {$0.order < $1.order}
        self.BrandCollectionView.reloadData()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier ==  "SearchToResultDetail"){
            let dvc = segue.destinationViewController as! ResultViewController
            dvc.productArray = products[0]
        } else if (segue.identifier == "showScan"){
            let dvc = segue.destinationViewController as! ScanViewController
            dvc.market = market!
        } else if (segue.identifier == "BrandDetails"){
            let brandDetailViewController = segue.destinationViewController as! BrandDetailViewController
            if let selectedBrandCell = sender as? customCollectionCell {
                let indexPath = BrandCollectionView.indexPathForCell(selectedBrandCell)!
                let selectedBrand = bestBrands[indexPath.row]
                brandDetailViewController.brands = selectedBrand
            }
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
        SearchTextField.endEditing(true)
        if (self.SearchTextField.text != ""){
            hideNoResults()
            eanCode = SearchTextField.text
            retrieveProducts(eanCode, market: market!, target: "search")
            showSearching()
        }
    }
    
    @IBAction func ScanButton(sender: UIButton) {
        performSegueWithIdentifier("showScan", sender: nil)
    }
    
    @IBAction func returnToSearchView(sender:UIStoryboardSegue) {
        segueTrigger=0
    }
}
