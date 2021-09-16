//
//  Currency.swift
//  StockExchange
//
//  Created by Danil on 12.09.2021.
//

import Foundation

struct Currency: Hashable {
    let id: Int
    let name: String
    let txFee: Double
    let minConf: Int
    let depositAddress: String?
    let disabled: Bool
    let delisted: Bool
    let frozen: Bool
    
    init(from currencyData: CurrencyData) {
        self.id = currencyData.id
        self.name = currencyData.name
        self.txFee = Double(currencyData.txFee) ?? 0
        self.minConf = currencyData.minConf
        self.depositAddress = currencyData.depositAddress
        self.disabled = Bool(truncating: currencyData.disabled as NSNumber)
        self.delisted = Bool(truncating: currencyData.delisted as NSNumber)
        self.frozen = Bool(truncating: currencyData.frozen as NSNumber)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.id == rhs.id
    }
}
