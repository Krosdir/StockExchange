//
//  InterfaceDelegate.swift
//  Market
//
//  Created by Danil on 06.09.2021.
//

import UIKit

protocol InterfaceDelegate: AnyObject {
    func updateInterface(_ sender: Any)
    func didFail(_ sender: Any, with error: MError)
}

extension InterfaceDelegate where Self: UIViewController {
    func updateInterface(_ sender: Any) {
//        hideActivity()
    }
    
    func didFail(_ sender: Any, with error: MError) {
        updateInterface(sender)
//        show(error)
    }
}

