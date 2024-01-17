//
//  ChartViewModel.swift
//  coinApp
//
//  Created by Vishal on 15/01/24.
//

import Foundation
import UIKit
import Charts

class ChartViewModel {
    var selectedCryptoId: String?
    var chartData: [Double] = []

    //MARK: Setting Data
    func setData(from model: homeCellModel) {
        let sparklineData = model.sparklineIn7D

        guard !sparklineData.price.isEmpty else {
            print("Error: sparklineIn7D.price is empty")
            return
        }

        chartData = sparklineData.price
        print("Chart Data: \(chartData)")
    }

    //MARK: fetching Chart Data
    func fetchChartData(completion: @escaping ([ChartDataEntry]) -> Void) {
        let entries = returnChartData()

        print("Chart Entries: \(entries)")

        completion(entries)
    }
    
    //MARK: Returning Chart
    func returnChartData() -> [ChartDataEntry] {
        var values: [ChartDataEntry] = []
        for (index, data) in chartData.enumerated() {
            let day = ChartDataEntry(x: Double(index), y: data)
            values.append(day)
        }
        return values
    }
    
    //MARK: fetch Highest And Lowest Prices
    func fetchHighestAndLowestPrices(completion: @escaping (Double?, Double?) -> Void) {
        // Check if chartData is not empty
        guard !chartData.isEmpty else {
            print("Error: chartData is empty")
            completion(nil, nil)
            return
        }

        // Fetch highest and lowest prices
        let highestPrice = chartData.max()
        let lowestPrice = chartData.min()

        print("Highest Price: \(highestPrice ?? 0.0)")
        print("Lowest Price: \(lowestPrice ?? 0.0)")

        completion(highestPrice, lowestPrice)
    }


}
