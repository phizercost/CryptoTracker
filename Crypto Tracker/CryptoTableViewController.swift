//
//  CryptoTableViewController.swift
//  Crypto Tracker
//
//  Created by Phizer Cost on 1/14/19.
//  Copyright © 2019 Phizer Cost. All rights reserved.
//

import UIKit

private let headerHeight: CGFloat = 100.0
private let netWorthHeight: CGFloat = 45.0


class CryptoTableViewController: UITableViewController, CoinDataDelegate {
    var amountLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        CoinData.shared.delegate = self
        CoinData.shared.getPrices()
        
    }
    
    
    
    func newPrices() {
        displayNetWorth()
        tableView.reloadData()
    }
    
    func createHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: headerHeight))
        headerView.backgroundColor = UIColor.white
        let networthLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.height, height: netWorthHeight))
        
        networthLabel.text = "My Crypto Net Worth:"
        networthLabel.textAlignment = .center
        headerView.addSubview(networthLabel)
        
        amountLabel.frame = CGRect(x: 0, y: netWorthHeight, width: view.frame.size.width, height: headerHeight - netWorthHeight)
        amountLabel.textAlignment = .center
        amountLabel.font = UIFont.boldSystemFont(ofSize: 60.0)
        headerView.addSubview(amountLabel)
        
        displayNetWorth()
        
        return headerView
        
    }
    
    func displayNetWorth () {
        amountLabel.text = CoinData.shared.netWorthAsString()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoinData.shared.coins.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeaderView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let coin = CoinData.shared.coins[indexPath.row]
        if coin.amount != 0.0 {
             cell.textLabel?.text = "\(coin.symbol) - \(coin.priceAsString()) - \(coin.amount)"
        } else {
            cell.textLabel?.text = "\(coin.symbol) - \(coin.priceAsString())"
        }
        cell.imageView?.image = coin.image
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coinVC = CoinViewController()
        coinVC.coin = CoinData.shared.coins[indexPath.row]
        navigationController?.pushViewController(coinVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CoinData.shared.delegate = self
        tableView.reloadData()
        displayNetWorth()
    }

}
