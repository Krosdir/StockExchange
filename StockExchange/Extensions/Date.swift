//
//  Date.swift
//  StockExchange
//
//  Created by Danil on 19.09.2021.
//

import Foundation

extension Date {
    var epoch: Int { return Int(self.timeIntervalSince1970) }
    static var epoch: Int { return Int(Date().timeIntervalSince1970) }
}
