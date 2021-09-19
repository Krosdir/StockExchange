//
//  ProfileViewController.swift
//  StockExchange
//
//  Created by Danil on 16.09.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var btcBalanceLabel: UILabel!
    @IBOutlet private weak var usdcBalanceLabel: UILabel!
    @IBOutlet private weak var btcAddressLabel: UILabel!
    @IBOutlet private weak var usdcAddressLabel: UILabel!
    
    var viewModel: ProfileViewModel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reloadData()
    }
    
    func reloadData() {
        showActivity()
        viewModel.reloadData()
    }
}

// MARK: - ProfileViewModelInterfaceDelegate
extension ProfileViewController: ProfileViewModelInterfaceDelegate {
    func updateInterface(_ sender: Any) {
        updateInterface()
    }
}

// MARK: - Private
private extension ProfileViewController {
    func updateInterface() {
        DispatchQueue.main.async { [self] in
            hideActivity()
            
            btcBalanceLabel.text = "\(viewModel.getBalance(for: .btc))"
            usdcBalanceLabel.text = "\(viewModel.getBalance(for: .usdc))"
            
            btcAddressLabel.text = viewModel.getAddress(for: .btc)
            usdcAddressLabel.text = viewModel.getAddress(for: .usdc)
        }
    }
}
