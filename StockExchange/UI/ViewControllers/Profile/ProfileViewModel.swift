//
//  ProfileViewModel.swift
//  StockExchange
//
//  Created by Danil on 19.09.2021.
//

import Foundation

protocol ProfileViewModelInterfaceDelegate: InterfaceDelegate {
}

enum CurrencyType: String, CaseIterable {
    case btc = "BTC"
    case usdc = "USDC"
}

class ProfileViewModel {
    weak var interfaceDelegate: ProfileViewModelInterfaceDelegate?
    
    private var balances: [CompleteBalance] = []
    private var addresses: [DepositAddress] = []
    
    func reloadData() {
        let dispatchGroup = DispatchGroup()
        getCompleteBalances(dispatchGroup: dispatchGroup)
        getDepositAddresses(dispatchGroup: dispatchGroup)
        
        dispatchGroup.notify(queue: .global()) { [weak self] in
            guard let self = self else { return }
            self.interfaceDelegate?.updateInterface(self)
        }
    }
    
    func getBalance(for type: CurrencyType) -> Double {
        let index = CurrencyType.allCases.firstIndex(of: type) ?? 0
        if balances.isEmpty {
            return 0.0
        } else {
            return balances[index].balances.available
        }
    }
    
    func getAddress(for type: CurrencyType) -> String {
        let index = CurrencyType.allCases.firstIndex(of: type) ?? 0
        if addresses.isEmpty {
            return "Empty"
        } else {
            return addresses[index].address
        }
    }
}

// MARK: - Private request methods
private extension ProfileViewModel {
    func getCompleteBalances(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        ProfileNetworkService.shared.getCompleteBalances { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                // TODO: error getCompleteBalances
                dispatchGroup.leave()
            case .success(let balances):
                let currencyTypes = CurrencyType.allCases
                for index in 0..<currencyTypes.count {
                    guard let balance = balances.first(where: { $0.currency == currencyTypes[index].rawValue }) else { continue }
                    self.balances.append(balance)
                }
                dispatchGroup.leave()
            }
        }
    }
    
    func getDepositAddresses(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        ProfileNetworkService.shared.getDepositAddresses { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                // TODO: error getCompleteBalances
                dispatchGroup.leave()
            case .success(let addresses):
                let currencyTypes = CurrencyType.allCases
                for index in 0..<currencyTypes.count {
                    guard let address = addresses.first(where: { $0.currency == currencyTypes[index].rawValue }) else { continue }
                    self.addresses.append(address)
                }
                dispatchGroup.leave()
            }
        }
    }
}
