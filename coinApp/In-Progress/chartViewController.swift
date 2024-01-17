//
//  chartViewController.swift
//  coinApp
//
//  Created by Vishal on 14/01/24.
//

import UIKit
import Charts

class chartViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet var chartCoinImage:UIImageView!
    @IBOutlet var chartCoinLabel:UILabel!
    @IBOutlet var chartCoinPrice:UILabel!
    
    @IBOutlet var exchangeBtnView:UIView!
    @IBOutlet var btnViewCollection:[UIView]!
    @IBOutlet var cellDataView:UIView!
    @IBOutlet var transactionView:UIView!
    @IBOutlet var chartView:UIView!
    
    var selectedCryptoId: String?
    var viewModel: ChartViewModel?
    var homeModel: homeCellModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exchangeBtnView.layer.cornerRadius = 12
        for btnView in btnViewCollection {
            btnView.layer.borderWidth = 1.0
            btnView.layer.cornerRadius = 10.0
            btnView.layer.borderColor = UIColor.black.cgColor
        }
        applyShadow(view: cellDataView)
        applyShadow(view: transactionView)
        setupViewModel()
    }
    
    //MARK: Shadow for views
    func applyShadow(view: UIView) {
        let cornerRadius: CGFloat = 8
        
        view.layer.cornerRadius = cornerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 4
        
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: 0, y: cornerRadius))
        shadowPath.addLine(to: CGPoint(x: view.bounds.width, y: cornerRadius))
        shadowPath.addLine(to: CGPoint(x: view.bounds.width, y: view.bounds.height - cornerRadius))
        shadowPath.addArc(withCenter: CGPoint(x: view.bounds.width - cornerRadius, y: view.bounds.height - cornerRadius),
                          radius: cornerRadius,
                          startAngle: 0,
                          endAngle: CGFloat(Double.pi / 2),
                          clockwise: true)
        shadowPath.addLine(to: CGPoint(x: cornerRadius, y: view.bounds.height))
        shadowPath.addArc(withCenter: CGPoint(x: cornerRadius, y: view.bounds.height - cornerRadius),
                          radius: cornerRadius,
                          startAngle: CGFloat(Double.pi / 2),
                          endAngle: CGFloat.pi,
                          clockwise: true)
        shadowPath.addLine(to: CGPoint(x: 0, y: cornerRadius))
        
        view.layer.shadowPath = shadowPath.cgPath
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    //MARK: Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Actions
    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func sellBtn(_ sender: UIButton) {
        
    }
    
    //MARK: Setting Viewmodel
    func setupViewModel() {
        guard let homeModel = homeModel else {
            print("Error: homeCellModel is nil.")
            return
        }
        
        print("SparklineIn7D Data: \(homeModel.sparklineIn7D)")
        
        if let selectedCryptoId = selectedCryptoId {
            viewModel = ChartViewModel()
            viewModel?.selectedCryptoId = selectedCryptoId
            viewModel?.setData(from: homeModel)
            viewModel?.fetchChartData { entries in
                self.updateChart(with: entries)
            }
        }
    }
    
    //MARK: Updating Chart
    func updateChart(with entries: [ChartDataEntry]) {
        guard !entries.isEmpty else {
            print("Error: Entries array is empty.")
            return
        }
        
        print("Number of entries: \(entries.count)")
        
        let dataSet = LineChartDataSet(entries: entries, label: "Crypto Price")
        dataSet.colors = [NSUIColor.blue]
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        
        let data = LineChartData(dataSet: dataSet)
        
        DispatchQueue.main.async { [self] in
            if let lineChartView = self.chartView as? LineChartView {
                lineChartView.data = data
                // Other UI updates
                lineChartView.chartDescription.text = "Crypto Price Chart"
                lineChartView.legend.enabled = true
                lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
                
                lineChartView.xAxis.drawGridLinesEnabled = false
                lineChartView.leftAxis.drawGridLinesEnabled = false
                lineChartView.rightAxis.drawGridLinesEnabled = false
                lineChartView.leftAxis.drawLabelsEnabled = false
                lineChartView.rightAxis.drawLabelsEnabled = false
                
                lineChartView.xAxis.drawAxisLineEnabled = false
                lineChartView.leftAxis.drawAxisLineEnabled = false
                lineChartView.rightAxis.drawAxisLineEnabled = false
                lineChartView.xAxis.drawLabelsEnabled = false
                
                print("Adding markers")
                
                viewModel?.fetchHighestAndLowestPrices { highestPrice, lowestPrice in
                    if let highest = highestPrice {
                        let highestEntry = ChartDataEntry(x: Double(entries.count - 1), y: highest)
                        self.addMarker(label: "₹ \(highest)", position: highestEntry)
                    }
                    
                    if let lowest = lowestPrice {
                        let lowestEntry = ChartDataEntry(x: 0, y: lowest)
                        self.addMarker(label: "₹ \(lowest)", position: lowestEntry)
                    }
                }
            }
        }
    }
    
    //MARK: Adding Labels
    func addMarker(label: String, position: ChartDataEntry) {
        print("addMarker called----")

        guard let lineChartView = self.chartView as? LineChartView else {
            return
        }

        let marker = CustomMarkerView()
        marker.chartView = lineChartView
        marker.label.text = label
        marker.label.textColor = UIColor.black

        // Print values for debugging
        print("Position - X: \(position.x), Y: \(position.y)")
        
        // Ensure the refreshContent method is called
        marker.refreshContent(entry: position, highlight: Highlight(x: position.x, y: position.y, dataSetIndex: 0))
        
        // Set marker's position exactly on the lowest point
        let markerPoint = lineChartView.getPosition(entry: position, axis: .left)
        
        // Print calculated marker position for debugging
        print("Marker Point - X: \(markerPoint.x), Y: \(markerPoint.y)")
        
        // Set marker's offset
        marker.offset = CGPoint(x: markerPoint.x - marker.bounds.width / 2, y: markerPoint.y - marker.bounds.height - 10)

        // Set marker on the main thread
        DispatchQueue.main.async {
            lineChartView.marker = marker
        }
    }


    
}

