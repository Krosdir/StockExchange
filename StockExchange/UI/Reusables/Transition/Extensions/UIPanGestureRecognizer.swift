//
//  UIPanGestureRecognizer.swift
//  StockExchange
//
//  Created by Danil on 18.09.2021.
//

import UIKit

extension UIPanGestureRecognizer {
    func increment(to direction: PresentationDirection, maxTranslation: CGRect) -> CGFloat {
        let translation = self.translation(in: view)
        setTranslation(.zero, in: nil)
        
        switch direction {
        case .fromLeft:
            return -translation.x / maxTranslation.width
        case .fromRight:
            return translation.x / maxTranslation.width
        case .fromTop:
            return -translation.y / maxTranslation.height
        case .fromBottom:
            return translation.y / maxTranslation.height
        }
    }
    
    func isProjectedToHalf(of direction: PresentationDirection, maxTranslation: CGRect) -> Bool {
        let endLocation = projectedLocation(decelerationRate: .fast)
        switch direction {
        case .fromLeft:
            return endLocation.x < maxTranslation.width / 2
        case .fromRight:
            return endLocation.x > maxTranslation.width / 2
        case .fromTop:
            return endLocation.y < maxTranslation.height / 2
        case .fromBottom:
            return endLocation.y > maxTranslation.height / 2
        }
    }
}

// MARK: - Private
private extension UIPanGestureRecognizer {
    func projectedLocation(decelerationRate: UIScrollView.DecelerationRate) -> CGPoint {
        let velocityOffset = velocity(in: view).projectedOffset(decelerationRate: .normal)
        let projectedLocation = location(in: view) + velocityOffset
        return projectedLocation
    }
}
