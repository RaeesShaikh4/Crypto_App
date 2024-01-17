//
//  profileTVC.swift
//  coinApp
//
//  Created by Vishal on 15/01/24.
//

import UIKit

class profileTVC: UITableViewCell {

    
    @IBOutlet var profileView:UIView!
    @IBOutlet var menuImg:UIImageView!
    @IBOutlet var menuOption:UILabel!
    @IBOutlet var menuBtn:UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
