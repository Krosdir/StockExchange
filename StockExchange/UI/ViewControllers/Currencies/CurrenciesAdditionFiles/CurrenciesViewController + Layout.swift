//
//  CurrenciesViewController + Layout.swift
//  StockExchange
//
//  Created by Danil on 15.09.2021.
//

import UIKit

extension CurrenciesViewController {
    func generateLayout(for section: Section) -> NSCollectionLayoutSection? {
        switch section {
        case .disabled:
            let item = generateItemLayout()
            let group = generateGroupLayout(itemLayout: item,
                                            groupSize: CurrenciesLayoutConstants.disabledGroupSize)
            let section = generateSectionLayout(groupLayout: group,
                                                headerHeight: CurrenciesLayoutConstants.headerHeight,
                                                spacing: CurrenciesLayoutConstants.spacing,
                                                insets: CurrenciesLayoutConstants.disabledSectionInsets,
                                                sectionScrollType: .continuous)
            return section
        case .delisted:
            let item = generateItemLayout()
            let group = generateGroupLayout(itemLayout: item,
                                            groupSize: CurrenciesLayoutConstants.delistedGroupSize,
                                            groupDirection: .vertical,
                                            insets: CurrenciesLayoutConstants.delistedGroupInsets,
                                            spacing: CurrenciesLayoutConstants.spacing,
                                            count: 2)
            let bigGroup = generateGroupLayout(itemLayout: item,
                                               groupSize: CurrenciesLayoutConstants.delistedGroupSize)
            let generalGroup = generateGroupLayout(subItems: [group, bigGroup],
                                                   groupSize: CurrenciesLayoutConstants.delistedGeneralGroupSize)
            let section = generateSectionLayout(groupLayout: generalGroup,
                                                headerHeight: CurrenciesLayoutConstants.headerHeight,
                                                spacing: CurrenciesLayoutConstants.spacing,
                                                insets: CurrenciesLayoutConstants.delistedSectionInsets,
                                                sectionScrollType: .groupPaging)
            return section
        case .frozen:
            let item = generateItemLayout()
            let group = generateGroupLayout(itemLayout: item,
                                            groupSize: CurrenciesLayoutConstants.frozenGroupSize)
            let section = generateSectionLayout(groupLayout: group,
                                                headerHeight: CurrenciesLayoutConstants.headerHeight,
                                                spacing: CurrenciesLayoutConstants.spacing,
                                                insets: CurrenciesLayoutConstants.frozenSectionInsets)
            return section
        }
    }
}
