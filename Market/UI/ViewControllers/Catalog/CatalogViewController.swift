//
//  CatalogViewController.swift
//  Market
//
//  Created by Danil on 06.09.2021.
//

import UIKit

class CatalogViewController: UIViewController {
    
    var viewModel: CatalogViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func reloadData() {
        viewModel.reloadData()
    }

}

// MARK: - CatalogViewModelInterfaceDelegate
extension CatalogViewController: CatalogViewModelInterfaceDelegate {
    
}
