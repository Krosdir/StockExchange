//
//  PresentAnimation.swift
//  StockExchange
//
//  Created by Danil on 18.09.2021.
//

import UIKit

class PresentAnimation: NSObject {
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
extension PresentAnimation: UIViewControllerAnimatedTransitioning {
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
private extension PresentAnimation {
    func animator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        guard let viewTo = transitionContext.view(forKey: .to),
              let viewControllerTo = transitionContext.viewController(forKey: .to) else {
            return UIViewPropertyAnimator(duration: duration, curve: .easeOut)
        }
        
        // Frame from PresentationController
        let finalFrame = transitionContext.finalFrame(for: viewControllerTo)
        
        // Moving the controller off the edge of the screen
        var dismissedFrame = finalFrame
          switch presentationDirection {
          case .fromLeft:
            dismissedFrame.origin.x = -finalFrame.width
          case .fromRight:
            dismissedFrame.origin.x = transitionContext.containerView.frame.size.width
          case .fromTop:
            dismissedFrame.origin.y = -finalFrame.height
          case .fromBottom:
            dismissedFrame.origin.y = transitionContext.containerView.frame.size.height
          }
        
        viewTo.frame = dismissedFrame
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
            viewTo.frame = finalFrame
        }
        
        animator.addCompletion { position in
            // If transition isn't cancelled, finish it
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        return animator
    }
}
