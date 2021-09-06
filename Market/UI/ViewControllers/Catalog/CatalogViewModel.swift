//
//  CatalogViewModel.swift
//  Market
//
//  Created by Danil on 06.09.2021.
//

import Foundation

protocol CatalogViewModelInterfaceDelegate: InterfaceDelegate {
    
}

protocol CatalogViewModelActionDelegate: AnyObject {
}


struct CatalogViewModel {
    weak var interfaceDelegate: CatalogViewModelInterfaceDelegate?
    weak var actionDelegate: CatalogViewModelActionDelegate?

    init() { }
    
    func reloadData() {
        
    }
}
