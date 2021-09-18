//
//  DimPresentationController.swift
//  StockExchange
//
//  Created by Danil on 18.09.2021.
//

import UIKit

class DimPresentationController: PresentationController {
    private lazy var dimView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.alpha = 0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        guard let containerView = containerView else { return }
        dimView.frame = containerView.frame
    }
}

// MARK: - Presentation Transition Methods
extension DimPresentationController {
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.insertSubview(dimView, at: 0)
        performAlongsideTransitionIfPossible { [unowned self] in
            self.dimView.alpha = 1
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        if !completed {
            dimView.removeFromSuperview()
        }
    }
}

// MARK: - Dismissal Transition Methods
extension DimPresentationController {
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        performAlongsideTransitionIfPossible { [unowned self] in
            self.dimView.alpha = 0
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        if completed {
            dimView.removeFromSuperview()
        }
    }
}

// MARK: - Private
private extension DimPresentationController {
    func performAlongsideTransitionIfPossible(_ completion: @escaping () -> Void) {
        guard let coordinator = self.presentedViewController.transitionCoordinator else {
            completion()
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            completion()
        })
    }
    
    @objc func dismissController() {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}
