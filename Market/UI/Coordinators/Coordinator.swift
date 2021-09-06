//
//  Coordinator.swift
//  Market
//
//  Created by Danil on 06.09.2021.
//

import UIKit

class Coordinator: NSObject {
    var children: [Coordinator] = []
    private(set) weak var parent: Coordinator?
    
    let rootNavigationController: UINavigationController
    
    required init(root: UINavigationController, parent: Coordinator? = nil) {
        self.parent = parent
        self.rootNavigationController = root
    }
    
    func childWillFinish(_ child: Coordinator) {
        
    }
    
    func childDidFinish(_ child: Coordinator) {
        children.removeAll(where: { $0 === child })
    }
    
    func start() {
        
    }
    
    func reloadData() {
        children.forEach { $0.reloadData() }
    }
    
    func present(_ coordinator: Coordinator, animated: Bool) {
        children.append(coordinator)
        
        coordinator.start()
        
        if let presentedViewController = rootNavigationController.presentedViewController {
            presentedViewController.dismiss(animated: false) {
                self.rootNavigationController.present(coordinator.rootNavigationController, animated: animated)
            }
        } else {
            rootNavigationController.present(coordinator.rootNavigationController, animated: animated)
        }
    }
}
