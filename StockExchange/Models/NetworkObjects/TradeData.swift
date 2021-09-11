//
//  TradeData.swift
//  Market
//
//  Created by Danil on 11.09.2021.
//

import Foundation

struct TradeData: Codable {
    let globalTradeID: Int
    let tradeID: Int
    let date: String
    let type: String
    let rate: String
    let amount: String
    let total: String
    
    init(from trade: Trade) {
        globalTradeID = trade.globalTradeID
        tradeID = trade.tradeID
        date = trade.date
        type = trade.type.rawValue
        rate = "\(trade.rate)"
        amount = "\(trade.amount)"
        total = "\(trade.total)"
    }
}
