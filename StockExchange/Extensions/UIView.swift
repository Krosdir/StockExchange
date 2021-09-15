//
//  UIView.swift
//  StockExchange
//
//  Created by Danil on 11.09.2021.
//

import UIKit

extension UIView {
    @discardableResult
    func fromNib<T: UIView>() -> T {
        guard let contentView = Bundle(for: type(of: self))
            .loadNibNamed(
                String(describing: type(of: self)),
                owner: self,
                options: nil
            )?.first as? T else {
                fatalError()
        }
        insertSubview(contentView, at: 0)
        contentView.translatesAutoresizingMaskIntoConstraints = true
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return contentView
    }
    
    func transition(with duration: TimeInterval = 0.25, animations: @escaping () -> Void) {
        UIView.transition(
            with: self,
            duration: duration,
            options: [.transitionCrossDissolve],
            animations: animations,
            completion: nil
        )
    }
    
    func hideView<T: UIView>(_ type: T.Type) {
        guard let view = subviews.first(where: { $0 is T }) else { return }
        transition { view.removeFromSuperview() }
    }
    
    func showView<T: UIView>(configure: ((T) -> Void)? = nil) -> T {
        let view = T(frame: bounds)
        view.translatesAutoresizingMaskIntoConstraints = true
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        configure?(view)
        
        transition { self.addSubview(view) }
        
        return view
    }
    
    @discardableResult
    func showActivity() -> ActivityView {
        guard let loadingView = subviews.compactMap({ $0 as? ActivityView }).first else {
            return showView()
        }
        transition { self.bringSubviewToFront(loadingView) }
        return loadingView
    }
    
    func hideActivity() {
        hideView(ActivityView.self)
    }
}
