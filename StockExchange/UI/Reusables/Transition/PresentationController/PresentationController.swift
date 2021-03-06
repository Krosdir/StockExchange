//
//  PresentationController.swift
//  StockExchange
//
//  Created by Danil on 18.09.2021.
//

import UIKit

class PresentationController: UIPresentationController {
    
    private var presentationDirection: PresentationDirection = .fromBottom
    var driver: TransitionDriver!
    
    init(presentationDirection: PresentationDirection = .fromBottom,
         presentedViewController: UIViewController,
         presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.presentationDirection = presentationDirection
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let bounds = containerView?.bounds else { return .zero }
        var point: CGPoint = .zero
        var width = bounds.width
        var height = bounds.height
        
        switch presentationDirection {
        case .fromBottom:
            point = CGPoint(x: 0, y: bounds.height / 2)
            width = bounds.width
            height = bounds.height / 2
        case .fromTop:
            point = CGPoint(x: 0, y: 0)
            width = bounds.width
            height = bounds.height / 2
        case .fromLeft:
            point = CGPoint(x: 0, y: 0)
            width = bounds.width / 1.25
            height = bounds.height
        case .fromRight:
            point = CGPoint(x: bounds.width - (bounds.width / 1.25), y: 0)
            width = bounds.width / 1.25
            height = bounds.height
        }
        
        return CGRect(x: point.x,
                      y: point.y,
                      width: width,
                      height: height)
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        guard let presentedView = self.presentedView else { return }
        containerView?.addSubview(presentedView)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        
        if completed {
            driver.direction = .dismiss
        }
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        
        if completed {
            driver.direction = .present
        }
    }
}
