//
//  TopTabBarVC.swift
//  Bush Digital Production Rental
//
//  Created by Naveed ur Rehman on 29/08/2019.
//  Copyright © 2019 Naveed ur Rehman. All rights reserved.
//

import UIKit

class TopTabBarVC: GLViewPagerViewController, HomeVCDelegate {
    
    var viewControllers = [UIViewController]()
    var tabTitles = [String]()
    var count = 0
    var total_cats = [[Category]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let vc = UIStoryboard.storyBoard(withName: .main).loadViewController(withIdentifier: .HomeVC) as! HomeVC
        vc.delegate = self

        let searchBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: self, action: #selector(self.searchTap(_:)))
        self.navigationItem.rightBarButtonItem = searchBtn
        
        let logo = UIImage(named: "logowhite")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView

        getData()
    }
    
    @objc func searchTap(_ btn: UIBarButtonItem){
        
    }
    func didTapForDetail(cat: Category) {
        let vc = UIStoryboard.storyBoard(withName: .main).loadViewController(withIdentifier: .DetailVC) as! DetailVC
        vc.cat = cat
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func getData(){
        
        let dic = Dictionary<String,AnyObject>()
        Utility.shared.showSpinner()
        ALFWebService.sharedInstance.doGetData(parameters: dic, method: "api.php", success: { (response) in
            Utility.shared.hideSpinner()
            print(response)
            
            if let status = response["status"] as? Bool {
                if status {
                    if let categories_titles = response["categories_titles"] as? [String] {
                        
                        self.tabTitles = categories_titles
                        
                    }
                    if let categories = response["categories"] as? [[Dictionary<String,AnyObject>]] {
                        for cat in categories {
                            var cats = [Category]()
                            for c in cat {
                                cats.append(Category.init(fromDictionary: c))
                            }
                            self.total_cats.append(cats)
                        }
                    }
                    
                    self.setPagerValues()
                } else {
                    Utility.showAlertWithTitle(title: appName, withMessage: response["message"] as! String, withNavigation: self)
                }
            }
            
        }) { (response) in
            Utility.shared.hideSpinner()
            print(response)
        }
    
        
    }
    func setPagerValues(){
        
        self.viewControllers.removeAll()
        for _ in self.tabTitles {
            self.viewControllers.append(UIStoryboard.storyBoard(withName: .main).loadViewController(withIdentifier: .HomeVC) as! HomeVC)
        }
        print(self.viewControllers.count)
        
        self.setDataSource(newDataSource: self)
        self.setDelegate(newDelegate: self)
        self.padding = 20
        self.leadingPadding = 20
        self.trailingPadding = 20
        self.defaultDisplayPageIndex = 0
        self.tabAnimationType = GLTabAnimationType.GLTabAnimationType_WhileScrolling
        self.indicatorColor = UIColor.red
        
        self.supportArabic = false
        self.fixTabWidth = false
        self.fixIndicatorWidth = true
        
        
    }

}
// MARK: - GLViewPagerViewControllerDataSource
extension TopTabBarVC: GLViewPagerViewControllerDataSource,GLViewPagerViewControllerDelegate {
    
    func numberOfTabsForViewPager(_ viewPager: GLViewPagerViewController) -> Int {
        print(self.viewControllers.count)
        return self.viewControllers.count
    }
    
    func viewForTabIndex(_ viewPager: GLViewPagerViewController, index: Int) -> UIView {
        let label:UILabel = UILabel.init()
        label.text = self.tabTitles[index]
        label.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        label.textAlignment = NSTextAlignment.center
        label.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        return label
    }
    
    func contentViewControllerForTabAtIndex(_ viewPager: GLViewPagerViewController, index: Int) -> UIViewController {
        
        if let vc = self.viewControllers[index] as? HomeVC {
            vc.category = self.total_cats[index]
            vc.delegate = self
        }

        return self.viewControllers[index]
    }
    
    // MARK: - GLViewPagaerViewControllerDelegate
    func didChangeTabToIndex(_ viewPager: GLViewPagerViewController, index: Int, fromTabIndex: Int) {
        let prevLabel:UILabel = viewPager.tabViewAtIndex(index: fromTabIndex) as! UILabel
        let currentLabel:UILabel = viewPager.tabViewAtIndex(index: index) as! UILabel
        prevLabel.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
        currentLabel.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
        prevLabel.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        currentLabel.textColor = UIColor(hexString: "000000")
    }
    
    
    func widthForTabIndex(_ viewPager: GLViewPagerViewController, index: Int) -> CGFloat {
        let prototypeLabel:UILabel = UILabel.init()
        prototypeLabel.text = self.tabTitles[index]
        prototypeLabel.textAlignment = NSTextAlignment.center
        prototypeLabel.font = UIFont.systemFont(ofSize: 16.0)
        self.indicatorWidth = prototypeLabel.intrinsicContentSize.width
        return prototypeLabel.intrinsicContentSize.width
    }
}
