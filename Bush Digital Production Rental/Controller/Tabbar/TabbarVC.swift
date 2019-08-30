//
//  TabbarVC.swift
//  WrenburyPrimarySchool
//
//  Created by Naveed ur Rehman on 06/10/2017.
//  Copyright © 2017 Naveed ur Rehman. All rights reserved.
//

import UIKit


class TabbarVC: UITabBarController,UITabBarControllerDelegate,UINavigationControllerDelegate{
    
    let homeVC = UIStoryboard.storyBoard(withName: .main).loadViewController(withIdentifier: .TopTabBarVC) as! TopTabBarVC
    let aboutVC = UIStoryboard.storyBoard(withName: .main).loadViewController(withIdentifier: .AboutVC) as! AboutVC

    let contactVC = UIStoryboard.storyBoard(withName: .main).loadViewController(withIdentifier: .ContactVC) as! ContactVC
    
    let moreVC = UIStoryboard.storyBoard(withName: .main).loadViewController(withIdentifier: .MoreVC) as! MoreVC
    
    init() {
        // perform some initialization here
        super.init(nibName: nil, bundle: nil)
        
        //                tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        
        
        /********************* For publication Tab *********************/
        
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "home"))
        
        homeVC.tabBarItem.tag = 0
        
        let homeUINav = UINavigationController(rootViewController: homeVC)
        
        /*******************************************************/
        
        aboutVC.tabBarItem = UITabBarItem(title: "About", image: #imageLiteral(resourceName: "about"), selectedImage: #imageLiteral(resourceName: "about"))
        
        aboutVC.tabBarItem.tag = 1
        //
        let aboutUINav = UINavigationController(rootViewController: aboutVC)
        
        /********************* For schedule Tab *********************/
        
        contactVC.tabBarItem = UITabBarItem(title: "Contac", image: #imageLiteral(resourceName: "contact"), selectedImage: #imageLiteral(resourceName: "contact"))
        contactVC.tabBarItem.tag = 2
        
        let contactUINav = UINavigationController(rootViewController: contactVC)
        
        /*******************************************************/
        
        
       
        /********************* For schedule Tab *********************/
        
        moreVC.tabBarItem = UITabBarItem(title: "More", image: #imageLiteral(resourceName: "more"), selectedImage: #imageLiteral(resourceName: "more"))
        
        moreVC.tabBarItem.tag = 2
        
        let moreUINav = UINavigationController(rootViewController: moreVC)
        
        /*******************************************************/
        
        //        viewControllers = [homeVC,videoVC,profileVC]
        viewControllers = [homeUINav,aboutUINav,contactUINav,moreUINav]
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.delegate = self
        self.tabBar.isTranslucent = false
        
        self.tabBar.barTintColor = UIColor(hexString: "#064E8B")
        self.tabBar.tintColor = UIColor(hexString: "#FFFFFF")
        if #available(iOS 10.0, *) {
            //            self.tabBar.unselectedItemTintColor = UIColor(hexString: "#d23436")
        } else {
            // Fallback on earlier versions
        }
        //        self.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -14)
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
        //        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Roboto-Regular", size: 12)!], for: .normal)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController){
    //
    //        let tag = viewController.tabBarItem.tag
    //
    //        if viewController == tabBarController.moreNavigationController {
    ////            tabBarController.moreNavigationController.delegate = self
    //            self.title = "More"
    //        } else {
    ////            findSelectedTagForTabBarController(tabBarController)
    //            switch tag {
    //            case 0:
    //                self.title = "Home"
    //            case 1:
    //                self.title = "Directories"
    //            case 2:
    //                self.title = "Members"
    //            case 3:
    //                self.title = "Calendar"
    //            case 4:
    //                self.title = "Check In"
    //            case 5:
    //                self.title = "Sign Up"
    //            case 5:
    //                self.title = "Sign Up 2"
    //            default: break
    //
    //            }
    //
    //        }
    //
    //           }
    
    
    private func findSelectedTagForTabBarController(tabBarController: UITabBarController?) {
        
        if let tabBarController = tabBarController {
            if let viewControllers = tabBarController.viewControllers {
                let selectedIndex = tabBarController.selectedIndex
                let selectedController: UIViewController? = viewControllers.count > selectedIndex ? viewControllers[selectedIndex] : nil
                if let tag = selectedController?.tabBarItem.tag {
                    //here you can use your tag
                    print(tag)
                }
            }
        }
    }
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //findSelectedTagForTabBarController(navigationController.tabBarController)
        print("print \(viewController)")
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    //    override func viewWillLayoutSubviews()
    //    {
    //        var tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    //    tabFrame.size.height = -88;
    //    tabFrame.origin.y = self.view.frame.size.height - 44;
    //    self.tabBar.frame = tabFrame;
    //    }
    
}




