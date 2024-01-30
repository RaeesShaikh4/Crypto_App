//
//  HomeViewController.swift
//  coinApp
//
//  Created by Vishal on 10/01/24.
//

import UIKit
import AlamofireImage


class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,homeCellViewModelDelegate{
    
    private var homeViewModel = homeCellViewModel()
    
    
    //MARK: Arrays
    var coinImgArr = ["Bitcoin","Band Protocol","Cardano","Ethereum","Tether","TRON"]
    var coinNameArr = ["Bitcoin","Band Protocol","Cardano","Ethereum","Tether","TRON"]
    var coinDescArr = ["BTC","ETH","BAND","ADA","TRX","ADAST"]
    var coinGraphArr = ["Bitcoin-Graph","Band Protocol-Graph","Cardano-Graph","Ethereum-Graph","Tether-Graph","TRON-Graph"]
    var coinPriceArr = ["₹2,509.75","₹2,809.75","₹553.06","₹105.06","₹5.29","₹73.00"]
    var coinProfitArr = [+9.77,-21.00,-22.97,+16.31,-16.58,+0.07]
    
    //MARK: Outlets
    @IBOutlet var homeTableView:UITableView!
    @IBOutlet var allBtn:UIButton!
    @IBOutlet var gainerBtn:UIButton!
    @IBOutlet var loserBtn:UIButton!
    @IBOutlet var favouriteBtn:UIButton!
    @IBOutlet var infoView: UIView!
    @IBOutlet var selectDropDown: UIView!
    
    var selectedButton: UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.delegate = self
        homeViewModel.fetchData()
        
        let nib = UINib(nibName: "homeTVC", bundle: nil)
        homeTableView.register(nib, forCellReuseIdentifier: "homeTVC")
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        selectDropDown.layer.borderWidth = 0.5
        selectDropDown.layer.cornerRadius = 12
        
        infoView.addBottomBorderWithColor(color: UIColor.lightGray, width: 1.0)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: - HomeCellViewModelDelegate
    func success() {
        DispatchQueue.main.async {
            print("Data Reloaded in success()----")
            self.homeTableView.reloadData()
        }
    }
    
    func failure(error:Error) {
        print("Error in fetchData: \(error.localizedDescription)")
    }
    
    //MARK: Actions
    @IBAction func selectAllButton(_ sender: UIButton) {
        print("selectAllButton clicked-----")
        homeViewModel.filterData(isGainer: nil)
        
        
    }
    
    @IBAction func selectGainerButton(_ sender: UIButton) {
        print("selectGainerButton clicked-----")
        homeViewModel.filterData(isGainer: true)
        
        
    }
    
    @IBAction func selectLoserButton(_ sender: UIButton) {
        print("selectLoserButton clicked-----")
        homeViewModel.filterData(isGainer: false)
        
        
    }
    
    @IBAction func selectFavouriteButton(_ sender: UIButton) {
        print("selectFavouriteButton clicked-----")
    }
    
    //MARK: TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if homeViewModel.filteredCryptos.isEmpty {
            // All cryptos array , If Filtercryptos is empty
            return homeViewModel.cryptos.count
        } else {
            // Displaying data from the filtered array
            return homeViewModel.filteredCryptos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTVC") as! homeTVC
        cell.homeTvcView.layer.cornerRadius = 15
        
        let crypto: homeCellModel
        
        if homeViewModel.filteredCryptos.isEmpty {
            // All cryptos array , If Filtercryptos is empty
            crypto = homeViewModel.cryptos[indexPath.row]
        } else {
            // Displaying data from the filtered array
            crypto = homeViewModel.filteredCryptos[indexPath.row]
        }
        
        // Using AlamofireImage
        if let imageURL = URL(string: crypto.image){
            cell.coinImage.af.setImage(withURL: imageURL)
        }
        
        cell.coinName.text = crypto.name
        cell.coinDetail.text = crypto.symbol
        cell.coinPrice.text = "₹ \(crypto.currentPrice)"
        cell.coinProfit.text = "\(crypto.priceChangePercentage24H)%"
        cell.coinStatusImage.image = UIImage(named: "Bitcoin-Graph")
        cell.coinProfit.textColor = homeViewModel.textColorForProfit(crypto.priceChangePercentage24H)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedCryptoId: String
        
        if homeViewModel.filteredCryptos.isEmpty {
            selectedCryptoId = homeViewModel.cryptos[indexPath.row].id
        } else {
            selectedCryptoId = homeViewModel.filteredCryptos[indexPath.row].id
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let chartVC = storyboard.instantiateViewController(withIdentifier: "chartViewController") as? chartViewController {
            chartVC.selectedCryptoId = selectedCryptoId
            chartVC.homeModel = homeViewModel.cryptos[indexPath.row] // Passing the selected homeCellModel
           
            
            navigationController?.pushViewController(chartVC, animated: true)
        }
    }
    
}

//MARK: Uiview Design
extension UIView {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: frame.size.height - width, width: frame.size.width, height: width)
        layer.addSublayer(border)
    }
}


