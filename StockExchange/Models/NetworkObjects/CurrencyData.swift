//
//  CurrencyData.swift
//  StockExchange
//
//  Created by Danil on 12.09.2021.
//

import Foundation

struct CurrencyData: Codable {
    let id: Int
    let name: String
    let txFee: String
    let minConf: Int
    let depositAddress: String?
    let disabled: Int
    let delisted: Int
    let frozen: Int
    
    init(from currency: Currency) {
        self.id = currency.id
        self.name = currency.name
        self.txFee = "\(currency.txFee)"
        self.minConf = currency.minConf
        self.depositAddress = currency.depositAddress
        self.disabled = currency.disabled ? 1 : 0
        self.delisted = currency.delisted ? 1 : 0
        self.frozen = currency.frozen ? 1 : 0
    }
}
