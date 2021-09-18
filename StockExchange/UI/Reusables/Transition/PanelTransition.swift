//
//  PanelTransition.swift
//  StockExchange
//
//  Created by Danil on 18.09.2021.
//

import UIKit

enum PresentationDirection {
    case fromBottom
    case fromTop
    case fromLeft
    case fromRight
}

class PanelTransition: NSObject {
    
    private let driver = TransitionDriver()
    private var presentationDirection: PresentationDirection!
    private var duration: TimeInterval!
    
    init(presented: UIViewController,
         presenting: UIViewController,
         presentationDirection: PresentationDirection = .fromBottom,
         duration: TimeInterval) {
        super.init()
        self.presentationDirection = presentationDirection
        self.duration = duration
        driver.linkPresentationGesture(to: presented,
                                       presentingController: presenting,
                                       direction: presentationDirection)
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension PanelTransition: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        let presentationController = DimPresentationController(presentationDirection: presentationDirection,
                                                               presentedViewController: presented,
                                                               presenting: presenting ?? source)
        presentationController.driver = driver
        return presentationController
    }
    
    // MARK: Animation
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation(presentationDirection: presentationDirection, duration: duration)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation(presentationDirection: presentationDirection, duration: duration)
    }
    
    // MARK: Interaction
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return driver
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return driver
    }
}
