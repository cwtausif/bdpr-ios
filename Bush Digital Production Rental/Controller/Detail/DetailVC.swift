//
//  DetailVC.swift
//  Bush Digital Production Rental
//
//  Created by Naveed ur Rehman on 29/08/2019.
//  Copyright © 2019 Naveed ur Rehman. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var botView: UIView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var descrip: UILabel!
    @IBOutlet weak var rp1: UILabel!
    @IBOutlet weak var rp2: UILabel!
    @IBOutlet weak var rp3: UILabel!
    
    
    var cat: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        botView.clipsToBounds = true
        botView.layer.cornerRadius = 40
        botView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.addBackbutton(title: "")
        
        let logo = UIImage(named: "logowhite")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        setVals()
    }
    
    func setVals(){
        
        mainTitle.text = cat!.title.withoutHtml
        rp1.text = "$\(String(describing: cat!.pOne!)) for 1 day"
        rp2.text = "$\(String(describing: cat!.pTwo!)) for 1 day"
        rp3.text = "$\(String(describing: cat!.pThree!)) for 1 day"
        descrip.text = cat!.descriptionField.withoutHtml
        img.setImageWith(URL(string: cat!.image)!)
    }
    
    @IBAction func callEmailTap(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
