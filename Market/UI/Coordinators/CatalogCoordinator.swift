//
//  CatalogCoordinator.swift
//  Market
//
//  Created by Danil on 06.09.2021.
//

import UIKit

class CatalogCoordinator: Coordinator {
    let catalogViewController = CatalogViewController.fromNib()
    
    required init(root: UINavigationController, parent: Coordinator? = nil) {
        super.init(root: root, parent: parent)
        
        catalogViewController.viewModel = CatalogViewModel()
        catalogViewController.viewModel.actionDelegate = self
        catalogViewController.viewModel.interfaceDelegate = catalogViewController
        
        rootNavigationController.isNavigationBarHidden = true
        rootNavigationController.tabBarItem = UITabBarItem(
            title: "Catalog".uppercased(),
            image: UIImage(named: "Power Hour"),
            selectedImage: UIImage(named: "Power Hour")
        )
    }
    
    override func start() {
        rootNavigationController.pushViewController(catalogViewController, animated: false)
    }
    
    override func reloadData() {
        super.reloadData()
        
        catalogViewController.reloadData()
    }
}

// MARK: - CatalogViewModelActionDelegate
extension CatalogCoordinator: CatalogViewModelActionDelegate {
    
}
