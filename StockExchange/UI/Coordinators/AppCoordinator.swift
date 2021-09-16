//
//  AppCoordinator.swift
//  StockExchange
//
//  Created by Danil on 06.09.2021.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let tabBarController = UITabBarController()
    
    private(set) var tradeHistoryCoordinator: TradeHistoryCoordinator!
    private(set) var currenciesCoordinator: CurrenciesCoordinator!
    
    required init(root: UINavigationController, parent: Coordinator? = nil) {
        super.init(root: root, parent: parent)
        
        currenciesCoordinator = CurrenciesCoordinator(root: UINavigationController(), parent: self)
        tradeHistoryCoordinator = TradeHistoryCoordinator(root: UINavigationController(), parent: self)
        
        setupNavigationItems(to: tabBarController)
        tabBarController.tabBar.unselectedItemTintColor = .gray
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.barTintColor = .white
        rootNavigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.paleGray]
        
        rootNavigationController.pushViewController(tabBarController, animated: false)
    }
    
    override func start() {
        children = [
            currenciesCoordinator,
            tradeHistoryCoordinator
        ]
        
        children.forEach({ $0.start() })
        
        tabBarController.setViewControllers(
            children.map { $0.rootNavigationController },
            animated: false
        )
    }
    
    override func reloadData() {
        super.reloadData()
    }
    
    override func childDidFinish(_ child: Coordinator) {
        super.childDidFinish(child)
    }
}

// MARK: - Private
private extension AppCoordinator {
    func setupNavigationItems(to viewController: UIViewController) {
        let profileButton = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: self,
            action: #selector(showProfile)
        )
        profileButton.tintColor = .paleGray
        

        viewController.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.paleGray]
        viewController.navigationItem.leftBarButtonItem = profileButton
        viewController.navigationItem.title = Bundle.main.infoDictionary?["CFBundleName"] as? String
    }
    
    @objc func showProfile() {
        
    }
}
