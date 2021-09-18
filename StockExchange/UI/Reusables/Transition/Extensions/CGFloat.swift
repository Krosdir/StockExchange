//
//  CGFloat.swift
//  StockExchange
//
//  Created by Danil on 18.09.2021.
//

import UIKit

extension CGFloat {
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGFloat {
        // Formula from WWDC
        let multiplier = 1 / (1 - decelerationRate.rawValue) / 1000
        return self * multiplier
    }
}
