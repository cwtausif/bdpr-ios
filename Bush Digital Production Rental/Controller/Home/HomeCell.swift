//
//  HomeCell.swift
//  Bush Digital Production Rental
//
//  Created by Naveed ur Rehman on 29/08/2019.
//  Copyright © 2019 Naveed ur Rehman. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var name2: UILabel!
    @IBOutlet weak var descrip: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func viewMoreTap(_ sender: Any) {
        
    }
}
