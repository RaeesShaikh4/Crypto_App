//
//  homeCellViewModel.swift
//  coinApp
//
//  Created by Vishal on 12/01/24.
//

//import Foundation
//import Alamofire
//
//protocol homeCellViewModelDelegate: AnyObject {
//    func success()
//    func failure(error: Error)
//}
//
//class homeCellViewModel{
//
//    var cryptos = [homeCellModel] ()
//    weak var delegate: homeCellViewModelDelegate?
//    var filteredCryptos: [homeCellModel] = []
//
//
//    private let apiUrl = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h"
//
//    func fetchData() {
//        AF.request(apiUrl).validate().responseDecodable(of: [homeCellModel].self) { response in
//            switch response.result {
//            case .success(let cryptosData):
//                DispatchQueue.main.async {
//                    self.cryptos = cryptosData
//                    self.delegate?.success()
//                    for crypto in self.cryptos {
//                        print("Crypto ID: \(crypto.id)")
//                        print("Name: \(crypto.name)")
//                        print("Symbol: \(crypto.symbol)")
//                        print("Current Price: \(crypto.currentPrice)")
//                        print("Market Cap Rank: \(crypto.marketCapRank)")
//                        print("----------------------------------")
//                    }
//                }
//            case .failure(let error):
//                self.delegate?.failure(error: error)
//                print("Error in fetchData: \(error.localizedDescription)")
//            }
//        }
//    }
//
//    //MARK: Color Filtering
//    func textColorForProfit(_ profit: Double) -> UIColor {
//        print("textColorForProfit called---")
//        if profit > 0 {
//            return .green
//        } else if profit < 0 {
//            return .red
//        } else {
//            return .black
//        }
//    }
//
//
//    func filterData(isGainer: Bool?) {
//        if let isGainer = isGainer {
//            if isGainer {
//                filteredCryptos = cryptos.filter { $0.priceChangePercentage24H > 0 }
//            } else {
//                filteredCryptos = cryptos.filter { $0.priceChangePercentage24H < 0 }
//            }
//        } else {
//            // If isGainer is nil, showing all data
//            filteredCryptos = cryptos
//        }
//        delegate?.success()
//    }
//
//
//}

import Foundation
import UIKit

protocol homeCellViewModelDelegate: AnyObject {
    func success()
    func failure(error: Error)
}

class homeCellViewModel {
    var cryptos = [homeCellModel]()
    weak var delegate: homeCellViewModelDelegate?
    var filteredCryptos: [homeCellModel] = []

    private let apiCaller = APICaller.shared

    func fetchData() {
        apiCaller.fetchData { [weak self] result in
            switch result {
            case .success(let cryptosData):
                DispatchQueue.main.async {
                    self?.cryptos = cryptosData
                    self?.delegate?.success()
                    for crypto in self?.cryptos ?? [] {
                        print("Crypto ID: \(crypto.id)")
                        print("Name: \(crypto.name)")
                        print("Symbol: \(crypto.symbol)")
                        print("Current Price: \(crypto.currentPrice)")
                        print("Market Cap Rank: \(crypto.marketCapRank)")
                        print("----------------------------------")
                    }
                }
            case .failure(let error):
                self?.delegate?.failure(error: error)
                print("Error in fetchData: \(error.localizedDescription)")
            }
        }
    }

    // MARK: Color Filtering
    func textColorForProfit(_ profit: Double) -> UIColor {
        print("textColorForProfit called---")
        if profit > 0 {
            return .green
        } else if profit < 0 {
            return .red
        } else {
            return .black
        }
    }

    func filterData(isGainer: Bool?) {
        if let isGainer = isGainer {
            if isGainer {
                filteredCryptos = cryptos.filter { $0.priceChangePercentage24H > 0 }
            } else {
                filteredCryptos = cryptos.filter { $0.priceChangePercentage24H < 0 }
            }
        } else {
            // If isGainer is nil, showing all data
            filteredCryptos = cryptos
        }
        delegate?.success()
    }
}
