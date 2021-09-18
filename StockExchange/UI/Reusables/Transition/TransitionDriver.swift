//
//  TransitionDriver.swift
//  StockExchange
//
//  Created by Danil on 18.09.2021.
//

import UIKit

enum TransitionDirection {
    case present
    case dismiss
}

class TransitionDriver: UIPercentDrivenInteractiveTransition {
    private weak var presentingController: UIViewController?
    private weak var presentedController: UIViewController?
    private var panRecognizer: UIPanGestureRecognizer!
    private var screenEdgePanRecognizer: UIScreenEdgePanGestureRecognizer!
    private var presentationDirection: PresentationDirection = .fromBottom
    var direction: TransitionDirection = .present
    
    /// `pause()` before call `isRunning`
    private var isRunning: Bool {
        return percentComplete != 0
    }
    
    var maxTranslation: CGRect {
        return presentedController?.view.frame ?? .zero
    }
    
    override var wantsInteractiveStart: Bool {
        get {
            switch direction {
            case .present:
                return false
            case .dismiss:
                let gestureIsActive = panRecognizer?.state == .began
                return gestureIsActive
            }
        }
        set { }
    }
    
    func linkPresentationGesture(to presentedController: UIViewController,
                                 presentingController: UIViewController,
                                 direction: PresentationDirection) {
        self.presentedController = presentedController
        self.presentingController = presentingController
        self.presentationDirection = direction
        
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(recognizer:)))
        presentedController.view.addGestureRecognizer(panRecognizer)
        
        screenEdgePanRecognizer = UIScreenEdgePanGestureRecognizer(target: self,
                                                                   action: #selector(handlePresentation(recognizer:)))
        switch direction {
        case .fromLeft:
            screenEdgePanRecognizer.edges = .left
        case .fromRight:
            screenEdgePanRecognizer.edges = .right
        case .fromTop:
            screenEdgePanRecognizer.edges = .top
        case .fromBottom:
            screenEdgePanRecognizer.edges = .bottom
        }
        presentingController.view.addGestureRecognizer(screenEdgePanRecognizer)
    }
}

// MARK: - Private Gesture Handling Methods
private extension TransitionDriver {
    @objc private func handleGesture(recognizer: UIPanGestureRecognizer) {
        switch direction {
        case .present:
            handlePresentation(recognizer: recognizer)
        case .dismiss:
            handleDismiss(recognizer: recognizer)
        }
    }
    
    @objc private func handlePresentation(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            pause()
            
            if !isRunning,
               let presentedController = self.presentedController {
                presentingController?.present(presentedController, animated: true)
            }
        case .changed:
            let increment = -recognizer.increment(to: presentationDirection, maxTranslation: maxTranslation)
            update(percentComplete + increment)
        case .ended, .cancelled:
            if recognizer.isProjectedToHalf(of: presentationDirection, maxTranslation: maxTranslation) {
                cancel()
            } else {
                finish()
            }
        case .failed:
            cancel()
        default:
            break
        }
    }
    
    func handleDismiss(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            pause() // Pause allows to detect isRunning
            
            if !isRunning {
                presentedController?.dismiss(animated: true)
            }
        case .changed:
            update(percentComplete + recognizer.increment(to: presentationDirection, maxTranslation: maxTranslation))
        case .ended, .cancelled:
            if recognizer.isProjectedToHalf(of: presentationDirection, maxTranslation: maxTranslation) {
                finish()
            } else {
                cancel()
            }
        case .failed:
            cancel()
        default:
            break
        }
    }
}
