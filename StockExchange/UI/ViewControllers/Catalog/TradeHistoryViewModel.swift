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

enum TradeHistoryType: String, CaseIterable {
    case btcEth = "BTC_ETH"
    case usdcBtc = "USDC_BTC"
    case usdtBtc = "USDT_BTC"
}

class TradeHistoryViewModel {
    weak var interfaceDelegate: TradeHistoryViewModelInterfaceDelegate?
    weak var actionDelegate: TradeHistoryViewModelActionDelegate?
    
    private var historyType: TradeHistoryType = .btcEth
    
    private var trades: [Trade] = []
    private var buyTrades: [Trade] = []
    private var sellTrades: [Trade] = []
    
    var numberOfSections: Int { 2 }
    
    init() { }
    
    func reloadData() {
        getTradeHistory()
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
    
    func updateHistoryType(with index: Int) {
        historyType = TradeHistoryType.allCases[index]
        reloadData()
    }
}

// MARK: - TradeTableViewSectionHeaderViewModelDelegate
extension TradeHistoryViewModel: TradeTableViewSectionHeaderViewModelDelegate {
    func viewModelDidSelect(_ viewModel: TradeTableViewSectionHeaderViewModel) {
        // TODO: section viewModelDidSelect
    }
}

// MARK: - Private request methods
private extension TradeHistoryViewModel {
    func getTradeHistory() {
        TradeHistoryNetworkService.shared.getTradeHistory(for: historyType) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                // TODO: error getTradeHistory
            break
            case .success(let trades):
                self.trades = trades
                self.buyTrades = trades.filter { $0.type == .buy }
                self.sellTrades = trades.filter { $0.type == .sell }
                self.interfaceDelegate?.updateInterface(self)
            }
        }
    }
}
