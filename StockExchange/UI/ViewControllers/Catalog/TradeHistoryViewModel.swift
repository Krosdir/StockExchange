//
//  CatalogViewModel.swift
//  Market
//
//  Created by Danil on 06.09.2021.
//

import Foundation

protocol TradeHistoryViewModelInterfaceDelegate: InterfaceDelegate {
    func viewModel(_ viewModel: TradeHistoryViewModel, attemptsToReloadSection section: Int)
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
    
    private var sectionViewModels: [TradeTableViewSectionHeaderViewModel] = []
    private var trades: [Trade] = []
    private var buyTrades: [Trade] = []
    private var sellTrades: [Trade] = []
    
    private var selectedSectionsIndexes: [Int] = []
    
    var numberOfSections: Int { 2 }
    
    init() {
        getSectionModels()
    }
    
    func reloadData() {
        getTradeHistory()
    }
    
    func getNumberOfRows(for section: Int) -> Int {
        let trades = section == 0 ? buyTrades : sellTrades
        let isSelected = sectionViewModels[section].isSelected
        return isSelected ? trades.count : 0
    }
    
    func getHeaderViewModel(for section: Int) -> TradeTableViewSectionHeaderViewModel? {
        return sectionViewModels[section]
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
        guard let section = sectionViewModels.firstIndex(where: {$0 === viewModel}) else { return }
        sectionViewModels[section].isSelected.toggle()
        if !sectionViewModels[section].isSelected,
           let index = selectedSectionsIndexes.firstIndex(of: section) {
            selectedSectionsIndexes.remove(at: index)
        } else {
            selectedSectionsIndexes.append(section)
        }
        interfaceDelegate?.viewModel(self, attemptsToReloadSection: section)
    }
}

// MARK: - Private request methods
private extension TradeHistoryViewModel {
    func getSectionModels() {
        sectionViewModels.removeAll()
        for index in 0..<numberOfSections {
            guard let headerViewModel = headerViewModel(for: index) else { continue }
            sectionViewModels.append(headerViewModel)
        }
    }
    
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
    
    func headerViewModel(for section: Int) -> TradeTableViewSectionHeaderViewModel? {
        let type: TradeType = section == 0 ? .buy : .sell
        let headerViewModel = TradeTableViewSectionHeaderViewModel(type: type)
        headerViewModel.delegate = self
        return headerViewModel
    }
}
