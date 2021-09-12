//
//  CurrenciesViewModel.swift
//  StockExchange
//
//  Created by Danil on 12.09.2021.
//

import Foundation

protocol CurrenciesViewModelInterfaceDelegate: InterfaceDelegate {
}

protocol CurrenciesViewModelActionDelegate: AnyObject {
}


struct CurrenciesViewModel {
    weak var interfaceDelegate: CurrenciesViewModelInterfaceDelegate?
    weak var actionDelegate: CurrenciesViewModelActionDelegate?
}
