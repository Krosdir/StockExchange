//
//  UIViewController.swift
//  Market
//
//  Created by Danil on 06.09.2021.
//

import UIKit

extension UIViewController {
    static func fromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}
