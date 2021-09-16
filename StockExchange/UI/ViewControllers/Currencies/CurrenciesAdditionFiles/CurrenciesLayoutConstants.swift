//
//  CurrenciesLayoutConstants.swift
//  StockExchange
//
//  Created by Danil on 15.09.2021.
//

import UIKit

enum CurrenciesLayoutConstants {
    static let headerHeight = NSCollectionLayoutDimension.estimated(40)
    static let spacing: CGFloat = 10
    
    static let disabledGroupSize = (width: NSCollectionLayoutDimension.absolute(120),
                                       height: NSCollectionLayoutDimension.absolute(120))
    static let delistedGroupInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
    static let disabledSectionInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
    
    static let delistedGroupSize = (width: NSCollectionLayoutDimension.fractionalWidth(0.5),
                                    height: NSCollectionLayoutDimension.fractionalHeight(1))
    static let delistedGeneralGroupSize = (width: NSCollectionLayoutDimension.absolute(UIScreen.main.bounds.width - spacing * 2),
                                           height: NSCollectionLayoutDimension.absolute(240))
    static let delistedSectionInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
    
    static let frozenGroupSize = (width: NSCollectionLayoutDimension.fractionalWidth(1),
                                  height: NSCollectionLayoutDimension.estimated(180))
    static let frozenSectionInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
}
