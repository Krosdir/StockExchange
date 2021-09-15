//
//  Trade.swift
//  StockExchange
//
//  Created by Danil on 11.09.2021.
//

import Foundation

enum TradeType: String {
    case buy
    case sell
}

struct Trade {
    let globalTradeID: Int
    let tradeID: Int
    let date: String
    let type: TradeType
    let rate: Double
    let amount: Double
    let total: Double
    
    init(from tradeData: TradeData) {
        globalTradeID = tradeData.globalTradeID
        tradeID = tradeData.tradeID
        date = tradeData.date
        type = TradeType(rawValue: tradeData.type) ?? .buy
        rate = Double(tradeData.rate) ?? 0
        amount = Double(tradeData.amount) ?? 0
        total = Double(tradeData.total) ?? 0
    }
}
