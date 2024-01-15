//
//  APICaller.swift
//  coinApp
//
//  Created by Vishal on 13/01/24.
// APICaller.swift

import Foundation
import Alamofire

class APICaller {
    static let shared = APICaller()

    private let apiUrl = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h"

    func fetchData(completion: @escaping (Result<[homeCellModel], Error>) -> Void) {
        AF.request(apiUrl).validate().responseDecodable(of: [homeCellModel].self) { response in
            switch response.result {
            case .success(let cryptosData):
                completion(.success(cryptosData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
