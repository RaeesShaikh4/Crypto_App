//
//  homeTVC.swift
//  coinApp
//
//  Created by Vishal on 10/01/24.
//

import UIKit

class homeTVC: UITableViewCell {
    
    @IBOutlet var coinImage: UIImageView!
    @IBOutlet var coinName: UILabel!
    @IBOutlet var coinDetail: UILabel!
    @IBOutlet var coinPrice: UILabel!
    @IBOutlet var coinStatusImage: UIImageView!
    @IBOutlet var coinProfit: UILabel!
    @IBOutlet var homeTvcView: UIView!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
