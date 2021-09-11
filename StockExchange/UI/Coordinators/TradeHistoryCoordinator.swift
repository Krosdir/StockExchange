//
//  CatalogCoordinator.swift
//  Market
//
//  Created by Danil on 06.09.2021.
//

import UIKit

class TradeHistoryCoordinator: Coordinator {
    let tradeHistoryViewController = TradeHistoryViewController.fromNib()
    
    required init(root: UINavigationController, parent: Coordinator? = nil) {
        super.init(root: root, parent: parent)
        
        tradeHistoryViewController.viewModel = TradeHistoryViewModel()
        tradeHistoryViewController.viewModel.actionDelegate = self
        tradeHistoryViewController.viewModel.interfaceDelegate = tradeHistoryViewController
        
        rootNavigationController.isNavigationBarHidden = true
        rootNavigationController.tabBarItem = UITabBarItem(
            title: "Trade History".uppercased(),
            image: UIImage(named: "Power Hour"),
            selectedImage: UIImage(named: "Power Hour")
        )
    }
    
    override func start() {
        rootNavigationController.pushViewController(tradeHistoryViewController, animated: false)
    }
    
    override func reloadData() {
        super.reloadData()
        
        tradeHistoryViewController.reloadData()
    }
}

// MARK: - TradeHistoryViewModelActionDelegate
extension TradeHistoryCoordinator: TradeHistoryViewModelActionDelegate {
    
}
