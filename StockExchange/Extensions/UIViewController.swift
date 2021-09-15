//
//  UIViewController.swift
//  StockExchange
//
//  Created by Danil on 06.09.2021.
//

import UIKit

extension UIViewController {
    static func fromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
    
    @discardableResult
    func showActivity() -> ActivityView {
        view.showActivity()
    }
    
    func hideActivity() {
        view.hideActivity()
    }
}


// MARK: - CompositionLayout Support Methods
extension UIViewController {
    
    enum GroupDirection {
        case horizontal
        case vertical
    }
    
    func generateItemLayout(width: NSCollectionLayoutDimension? = nil,
                            height: NSCollectionLayoutDimension? = nil) -> NSCollectionLayoutItem {
        let size = NSCollectionLayoutSize(widthDimension: width ?? .fractionalWidth(1.0),
                                          heightDimension: height ?? .fractionalHeight(1.0))
        return NSCollectionLayoutItem(layoutSize: size)
    }
    
    func generateGroupLayout(itemLayout: NSCollectionLayoutItem,
                             groupSize: (width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension),
                             groupDirection: GroupDirection = .horizontal,
                             insets: NSDirectionalEdgeInsets = .zero,
                             spacing: CGFloat = 0,
                             count: Int = 1) -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: groupSize.width,
                                               heightDimension: groupSize.height)
        
        var group: NSCollectionLayoutGroup!
        switch groupDirection {
        case .horizontal:
            group = .horizontal(layoutSize: groupSize,
                                subitem: itemLayout,
                                count: count)
        case .vertical:
            group = .vertical(layoutSize: groupSize,
                              subitem: itemLayout,
                              count: count)
        }
        group.contentInsets = insets
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(spacing)
        return group
    }
    
    func generateGroupLayout(subItems: [NSCollectionLayoutItem],
                             groupSize: (width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension),
                             groupDirection: GroupDirection = .horizontal,
                             insets: NSDirectionalEdgeInsets = .zero,
                             spacing: CGFloat = 0) -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: groupSize.width,
                                               heightDimension: groupSize.height)
        
        var group: NSCollectionLayoutGroup!
        switch groupDirection {
        case .horizontal:
            group = .horizontal(layoutSize: groupSize, subitems: subItems)
        case .vertical:
            group = .vertical(layoutSize: groupSize, subitems: subItems)
        }
        group.contentInsets = insets
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(spacing)
        return group
    }
    
    func generateSectionLayout(groupLayout: NSCollectionLayoutGroup,
                               headerHeight: NSCollectionLayoutDimension? = nil,
                               spacing: CGFloat = 0,
                               insets: NSDirectionalEdgeInsets = .zero,
                               sectionScrollType: UICollectionLayoutSectionOrthogonalScrollingBehavior? = nil) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.orthogonalScrollingBehavior = sectionScrollType ?? .none
        if let headerHeight = headerHeight {
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: headerHeight)
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                            elementKind: UICollectionView.elementKindSectionHeader,
                                                                            alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
        }
        section.contentInsets = insets
        section.interGroupSpacing = spacing
        
        return section
    }
}
