//
//  CompleteBalances.swift
//  StockExchange
//
//  Created by Danil on 19.09.2021.
//

import Foundation

struct CompleteBalance {
    let currency: String
    let balances: Balances
    
    init(currency: String,
         balances: Balances) {
        self.currency = currency
        self.balances = balances
    }
}

struct Balances {
    let available: Double
    let onOrders: Double
    let btcValue: Double
    
    init(from balancesData: BalancesData) {
        available = Double(balancesData.available) ?? 0
        onOrders = Double(balancesData.onOrders) ?? 0
        btcValue = Double(balancesData.btcValue) ?? 0
    }
}
