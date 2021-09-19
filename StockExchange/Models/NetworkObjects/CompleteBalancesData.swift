//
//  CompleteBalancesData.swift
//  StockExchange
//
//  Created by Danil on 19.09.2021.
//

import Foundation

struct BalancesData: Codable {
    let available: String
    let onOrders: String
    let btcValue: String
    
    init(from balances: Balances) {
        available = "\(balances.available)"
        onOrders = "\(balances.onOrders)"
        btcValue = "\(balances.btcValue)"
    }
}
