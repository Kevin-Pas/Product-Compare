//
//  TestViewController.swift
//  TPD Compare
//
//  Created by STG Connect on 25/01/16.
//  Copyright © 2016 Scandinavian Tobacco Group. All rights reserved.
//

import UIKit
import Parse

/*
class TestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var MessageTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var dockViewHeight: NSLayoutConstraint!
    
    var messagesArray:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.MessageTableView.delegate = self
        self.MessageTableView.dataSource = self
        self.messageTextField.delegate = self
        
        // add tap gesture recognizer to the tableview
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tableViewTapped")
        self.MessageTableView.addGestureRecognizer(tapGesture)
        
        // Retrieve messages from Parse
        self.retrieveMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: Actions
    @IBAction func sendButtonTapped(sender: UIButton) {
        
        messageTextField.endEditing(true)

        self.messageTextField.enabled = false
        self.sendButton.enabled = false
        
        
        //Create PFObject
        var newMessageObject:PFObject = PFObject(className: "Message")
        
        // Set the Text key to the text of the MesageTextField
        newMessageObject["Text"] = self.messageTextField.text
        
        // Save the PFObject
        newMessageObject.saveInBackgroundWithBlock {
            (success, error) -> Void in
            if (success){
                // succesfully saved
                print("succesfully saved")
                self.retrieveMessages()
            } else {
                NSLog(error!.description)
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                self.messageTextField.enabled = true
                self.sendButton.enabled = true
                self.messageTextField.text = ""
            }
            
        }
    }
    
    
    /*func retrieveMessages() {
        var query:PFQuery = PFQuery(className:"BestBrands")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            // Clear the messagesArray
            self.messagesArray = [String]()
            
            // Loop through the objects array
            for messageObject in objects! {
                // Retrieve the Text Column value of each PFObject
                let messageText:String? = (messageObject as PFObject)["Brand"] as? String
                
                // Assign it into our messagesArray
                if messageText != nil {
                    self.messagesArray.append(messageText!)
                }
            }
            
            dispatch_async(dispatch_get_main_queue()){
                // Reload tableview
                self.MessageTableView.reloadData()
            }
            }
    }*/
    
    
    // MARK: Text field delegate methods
    func textFieldDidBeginEditing(textField: UITextField) {
        
        // Begin animation to grow dockview
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.5, animations: {
            self.dockViewHeight.constant = 350
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.5, animations: {
            self.dockViewHeight.constant = 70
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    

    func tableViewTapped(){
        messageTextField.endEditing(true)
    }
    
    
    // MARK: Table View Delegate Methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Create a table cell
        let cell = self.MessageTableView.dequeueReusableCellWithIdentifier("MessageCell")! as UITableViewCell
        
        // Customize cell
        cell.textLabel?.text = self.messagesArray[indexPath.row]
        
        // Return cell
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
}*/
