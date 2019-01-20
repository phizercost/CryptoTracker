//
//  CoinViewController.swift
//  Crypto Tracker
//
//  Created by Phizer Cost on 1/20/19.
//  Copyright © 2019 Phizer Cost. All rights reserved.
//

import UIKit
import SwiftChart



private let chartheight: CGFloat = 300.0
class CoinViewController: UIViewController, CoinDataDelegate {
    var chart = Chart()
    var coin: Coin?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoinData.shared.delegate = self
        edgesForExtendedLayout = []
        view.backgroundColor = UIColor.white
        
        chart.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: chartheight)
        chart.yLabelsFormatter = { CoinData.shared.doubleToMoneyString(double: $1) }
        chart.xLabels = [0,5,10,15,20,25,30]
        chart.xLabelsFormatter = { String(Int(round(30 - $1))) + "d" }
        view.addSubview(chart)
        coin?.getHistoricalData()
    }
    
    func newHistory() {
        
        if let coin = coin {
            let series = ChartSeries(coin.historicalData)
            series.area = true
            chart.add(series)
        }
    }
    
}
