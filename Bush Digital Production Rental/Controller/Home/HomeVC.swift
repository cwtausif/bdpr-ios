
//
//  HomeVC.swift
//  Bush Digital Production Rental
//
//  Created by Naveed ur Rehman on 28/08/2019.
//  Copyright © 2019 Naveed ur Rehman. All rights reserved.
//

import UIKit

@objc protocol HomeVCDelegate {
    @objc optional func didTapForDetail(cat: Category)
}

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbl: UITableView!
    
    var cat_index = 0
    var category = [Category]()
    var delegate: HomeVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbl.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeCell
        cell.name.text = category[indexPath.item].title.withoutHtml
        cell.name2.text = category[indexPath.item].title.withoutHtml
        cell.descrip.text = category[indexPath.item].descriptionField.withoutHtml
        cell.img.setImageWith(URL(string: category[indexPath.item].image)!)
        
        cell.whiteView.dropShadow(color: UIColor.lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapForDetail!(cat: category[indexPath.item])
        
    }
    

}
