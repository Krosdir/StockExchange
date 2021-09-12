//
//  CatalogCoordinator.swift
//  Market
//
//  Created by Danil on 06.09.2021.
//

import UIKit

class CurrenciesCoordinator: Coordinator {
    let currenciesViewController = CurrenciesViewController.fromNib()
    
    required init(root: UINavigationController, parent: Coordinator? = nil) {
        super.init(root: root, parent: parent)
        
        currenciesViewController.viewModel = CurrenciesViewModel()
        currenciesViewController.viewModel.actionDelegate = self
        currenciesViewController.viewModel.interfaceDelegate = currenciesViewController
        
        rootNavigationController.isNavigationBarHidden = true
        rootNavigationController.tabBarItem = UITabBarItem(
            title: "Currencies".uppercased(),
            image: UIImage(named: "Power Hour"),
            selectedImage: UIImage(named: "Power Hour")
        )
    }
    
    override func start() {
        rootNavigationController.pushViewController(currenciesViewController, animated: false)
    }
    
    override func reloadData() {
        super.reloadData()
        
        currenciesViewController.reloadData()
    }
}

// MARK: - CurrenciesViewModelActionDelegate
extension CurrenciesCoordinator: CurrenciesViewModelActionDelegate {
    
}
