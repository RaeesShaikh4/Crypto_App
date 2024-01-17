
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

    //MARK: Fetch Data from API
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

    // MARK: Data Filtering
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
