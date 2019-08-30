//
//  MoreVC.swift
//  Bush Digital Production Rental
//
//  Created by Naveed ur Rehman on 28/08/2019.
//  Copyright © 2019 Naveed ur Rehman. All rights reserved.
//

import UIKit

class MoreVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let logo = UIImage(named: "logowhite")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    

    @IBAction func btnsTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            //Pay
//            let vc = UIStoryboard.storyBoard(withName: .main).loadViewController(withIdentifier: .TermPrivacyVC) as! TermPrivacyVC
//            vc.vcTyp = .pay
//            self.navigationController?.pushViewController(vc, animated: true)
            if let url = URL(string: "https://bdproductionrental.com/payment.php") {
                UIApplication.shared.open(url)
            }
            
        } else if sender.tag == 1 {
            //privacy
//            let vc = UIStoryboard.storyBoard(withName: .main).loadViewController(withIdentifier: .TermPrivacyVC) as! TermPrivacyVC
//            vc.vcTyp = .privacy
//            self.navigationController?.pushViewController(vc, animated: true)
            if let url = URL(string: "https://www.bdproductionrental.com/privacy_policy.html") {
                UIApplication.shared.open(url)
            }
        } else if sender.tag == 2 {
            //Terms
//            let vc = UIStoryboard.storyBoard(withName: .main).loadViewController(withIdentifier: .TermPrivacyVC) as! TermPrivacyVC
//            vc.vcTyp = .term
//            self.navigationController?.pushViewController(vc, animated: true)
            if let url = URL(string: "https://www.bdproductionrental.com/rental-terms.php") {
                UIApplication.shared.open(url)
            }
        } else if sender.tag == 3 {
            //Call
            let number = "+905338219873"
            if let url = URL(string: "tel://\(number)"),
                UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler:nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            } else {
                // add error message here
            }
            
        } else if sender.tag == 4 {
            //Email
            self.tabBarController?.selectedIndex = 2
        } else if sender.tag == 5 {
            //FB
            if let url = URL(string: "https://www.facebook.com/BushDigitalProductionRental") {
                UIApplication.shared.open(url)
            }
        } else if sender.tag == 6 {
            //Twitter
            if let url = URL(string: "https://www.bdproductionrental.com/") {
                UIApplication.shared.open(url)
            }
        } else if sender.tag == 7 {
            //Insta
            if let url = URL(string: "https://www.instagram.com/bush_digital/") {
                UIApplication.shared.open(url)
            }
        }
    }
    

}
