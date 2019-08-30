//
//  AppStoryboards.swift
//  Workshop2u
//
//  Created by Waqas Ali on 11/20/16.
//  Copyright © 2016 Dinosoftlabs. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    //MARK:- Generic Public/Instance Methods
    
    func loadViewController(withIdentifier identifier: viewControllers) -> UIViewController {
        return self.instantiateViewController(withIdentifier: identifier.rawValue)
    }
    
    //MARK:- Class Methods to load Storyboards
    
    class func storyBoard(withName name: storyboards) -> UIStoryboard {
        return UIStoryboard(name: name.rawValue , bundle: Bundle.main)
    }
    
    class func storyBoard(withTextName name:String) -> UIStoryboard {
        return UIStoryboard(name: name , bundle: Bundle.main)
    }
    
}

enum storyboards : String {
    case main = "Main"
}

enum viewControllers: String {
    
    //Main Storyboard
    case HomeVC = "HomeVC",
    TopTabBarVC = "TopTabBarVC",
    AboutVC = "AboutVC",
    ContactVC = "ContactVC",
    MoreVC = "MoreVC",
    DetailVC = "DetailVC"
}
