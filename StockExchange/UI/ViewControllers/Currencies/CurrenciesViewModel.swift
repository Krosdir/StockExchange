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

enum Section: String, CaseIterable {
    case disabled = "Disabled"
    case delisted = "Delisted"
    case frozen = "Frozen"
}

enum SectionModel {
    case disabled(_ cellViewModel: DisabledCurrencyCellViewModel)
    case delisted(_ cellViewModel: DelistedCurrencyCellViewModel)
    case frozen(_ cellViewModel: FrozenCurrencyCellViewModel)
}

class CurrenciesViewModel {
    weak var interfaceDelegate: CurrenciesViewModelInterfaceDelegate?
    weak var actionDelegate: CurrenciesViewModelActionDelegate?
    
    private var currencies: [Currency] = []
    private var disabledCurrencies: [Currency] = []
    private var delistedCurrencies: [Currency] = []
    private var frozenCurrencies: [Currency] = []
    
    func reloadData() {
        getCurrencies()
    }

    func getSnapshotItems(for section: Section) -> [Currency] {
        switch section {
        case .disabled:
            return disabledCurrencies
        case .delisted:
            return delistedCurrencies
        case .frozen:
            return frozenCurrencies
        }
    }
    
    func sectionModel(for section: Section, with item: Currency) -> SectionModel? {
        switch section {
        case .disabled:
            return .disabled(DisabledCurrencyCellViewModel(name: item.name))
        case .delisted:
            return .delisted(DelistedCurrencyCellViewModel(id: item.id, name: item.name))
        case .frozen:
            let viewModel = FrozenCurrencyCellViewModel(name: item.name,
                                                        networkFee: item.txFee,
                                                        minAmount: item.minConf,
                                                        address: item.depositAddress)
            return .frozen(viewModel)
        }
    }
}

// MARK: - Private request methods
private extension CurrenciesViewModel {
    func getCurrencies() {
        CurrencyNetworkService.shared.getCurrencies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                // TODO: error getTradeHistory
                break
            case .success(let currencies):
                self.currencies = currencies
                self.disabledCurrencies = currencies.filter { $0.disabled }
                self.delistedCurrencies = currencies.filter { $0.delisted }
                self.frozenCurrencies = currencies.filter { $0.frozen }
                self.interfaceDelegate?.updateInterface(self)
            }
        }
    }
}
