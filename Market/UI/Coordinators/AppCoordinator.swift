//
//  AppCoordinator.swift
//  Market
//
//  Created by Danil on 06.09.2021.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let tabBarController = UITabBarController()
    
    required init(root: UINavigationController, parent: Coordinator? = nil) {
        super.init(root: root, parent: parent)
        
        tabBarController.tabBar.unselectedItemTintColor = .gray
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.barTintColor = .white
        
        rootNavigationController.pushViewController(tabBarController, animated: false)
    }
    
    override func start() {
        children = []
        
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
