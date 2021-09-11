//
//  CatalogViewModel.swift
//  Market
//
//  Created by Danil on 06.09.2021.
//

import Foundation

protocol TradeHistoryViewModelInterfaceDelegate: InterfaceDelegate {
    
}

protocol TradeHistoryViewModelActionDelegate: AnyObject {
}


struct TradeHistoryViewModel {
    weak var interfaceDelegate: TradeHistoryViewModelInterfaceDelegate?
    weak var actionDelegate: TradeHistoryViewModelActionDelegate?
    
    private var trades: [Trade] = []
    private var buyTrades: [Trade] = []
    private var sellTrades: [Trade] = []
    
    var numberOfSections: Int { 2 }
    
    init() { }
    
    func reloadData() {
        
    }
    
    func getNumberOfRows(for section: Int) -> Int {
        let trades = section == 0 ? buyTrades : sellTrades
        return trades.count
    }
    
    func headerViewModel(for section: Int) -> TradeTableViewSectionHeaderViewModel? {
        return TradeTableViewSectionHeaderViewModel(type: section == 0 ? .buy : .sell)
    }
    
    func cellViewModel(for indexPath: IndexPath) -> TradeCellViewModel? {
        let trades = indexPath.section == 0 ? buyTrades : sellTrades
        let trade = trades[indexPath.row]
        return TradeCellViewModel(rate: trade.rate, amount: trade.amount, total: trade.total)
    }
    
    // MARK: - TradeTableViewSectionHeaderViewModelDelegate
    extension TradeHistoryViewModel: TradeTableViewSectionHeaderViewModelDelegate {
        
    }
}
