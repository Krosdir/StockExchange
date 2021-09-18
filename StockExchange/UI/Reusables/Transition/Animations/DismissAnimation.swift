//
//  DismissAnimation.swift
//  StockExchange
//
//  Created by Danil on 18.09.2021.
//

import UIKit

class DismissAnimation: NSObject {
    private var duration: TimeInterval = 0.3
    private var presentationDirection: PresentationDirection = .fromBottom
    
    init(presentationDirection: PresentationDirection,
         duration: TimeInterval) {
        super.init()
        self.presentationDirection = presentationDirection
        self.duration = duration
    }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension DismissAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = self.animator(using: transitionContext)
        animator.startAnimation()
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return self.animator(using: transitionContext)
    }
}

// MARK: - Private
private extension DismissAnimation {
    private func animator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        guard let viewFrom = transitionContext.view(forKey: .from),
              let viewControllerFrom = transitionContext.viewController(forKey: .from) else {
            return UIViewPropertyAnimator(duration: duration, curve: .easeOut)
        }
        
        let initialFrame = transitionContext.finalFrame(for: viewControllerFrom)
        
        var dismissedFrame = initialFrame
          switch presentationDirection {
          case .fromLeft:
            dismissedFrame.origin.x = -initialFrame.width
          case .fromRight:
            dismissedFrame.origin.x = transitionContext.containerView.frame.size.width
          case .fromTop:
            dismissedFrame.origin.y = -initialFrame.height
          case .fromBottom:
            dismissedFrame.origin.y = transitionContext.containerView.frame.size.height
          }
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
            viewFrom.frame = dismissedFrame
        }
        
        animator.addCompletion { (position) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        return animator
    }
}
