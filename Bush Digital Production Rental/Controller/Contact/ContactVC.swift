//
//  ContactVC.swift
//  Bush Digital Production Rental
//
//  Created by Naveed ur Rehman on 28/08/2019.
//  Copyright © 2019 Naveed ur Rehman. All rights reserved.
//

import UIKit

var appName = "Bush Digital Production Rental"

class ContactVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var descripTxt: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let logo = UIImage(named: "logowhite")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func sendTap(_ sender: Any) {
        
        if nameTxt.text?.count == 0 {
            Utility.showAlertWithTitle(title: appName, withMessage: "Name is required!", withNavigation: self)
            return
        }
        if emailTxt.text?.count == 0 {
            Utility.showAlertWithTitle(title: appName, withMessage: "Email is required!", withNavigation: self)
            return
        }
        if descripTxt.text?.count == 0 {
            Utility.showAlertWithTitle(title: appName, withMessage: "Some info is required to contact us!", withNavigation: self)
            return
        }
        
        var dic = Dictionary<String,AnyObject>()
        
        dic["contact"] = true as AnyObject
        dic["name"] = nameTxt.text as AnyObject
        dic["email"] = emailTxt.text as AnyObject
        dic["message"] = descripTxt.text as AnyObject
        
        
        Utility.shared.showSpinner()
        ALFWebService.sharedInstance.doGetData(parameters: dic, method: "api.php", success: { (response) in
            Utility.shared.hideSpinner()
            print(response)
            
            if let status = response["status"] as? Bool {
                if status {
                   Utility.showAlertWithTitle(title: appName, withMessage: response["message"] as! String, withNavigation: self)
                } else {
                   Utility.showAlertWithTitle(title: appName, withMessage: response["message"] as! String, withNavigation: self)
                }
            }
            
        }) { (response) in
            Utility.shared.hideSpinner()
            print(response)
        }
    }
    
    

}
