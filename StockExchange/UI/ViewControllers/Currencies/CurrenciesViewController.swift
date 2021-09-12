//
//  CurrenciesViewController.swift
//  StockExchange
//
//  Created by Danil on 12.09.2021.
//

import UIKit

class CurrenciesViewController: UIViewController {
    
    var viewModel: CurrenciesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func reloadData() {
        
    }
}

// MARK: -
extension CurrenciesViewController: CurrenciesViewModelInterfaceDelegate {
    
}
