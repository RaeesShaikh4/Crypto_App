//
//  profileViewController.swift
//  coinApp
//
//  Created by Vishal on 15/01/24.
//

import UIKit

class profileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet var profileView:UIView!
    @IBOutlet var profileMenuTableView:UITableView!

    
    var profileIcons = ["History","Bank","Notifications","Security","Help","Terms","Log-out"]
    var profileMenu = ["History","Bank Details","Notifications","Security","Help and Support","Terms and Conditions","Log-out"]

    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.layer.cornerRadius = 12.0
        
        let nib = UINib(nibName: "profileTVC", bundle: nil)
        profileMenuTableView.register(nib, forCellReuseIdentifier: "profileTVC")
        profileMenuTableView.delegate = self
        profileMenuTableView.dataSource = self
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileTVC") as! profileTVC
        
        var images = profileIcons[indexPath.row]
        cell.menuImg.image = UIImage(named: images)
        cell.menuOption.text = profileMenu[indexPath.row]

        return cell
    }
    

  

}
