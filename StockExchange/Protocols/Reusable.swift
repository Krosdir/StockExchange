//
//  Reusable.swift
//  ThriveHD
//
//  Created by veimer on 2/4/21.
//

import UIKit
import MapKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: UICollectionViewCell {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

extension Reusable where Self: UICollectionReusableView {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

extension Reusable where Self: MKAnnotationView {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

extension Reusable where Self: MKPointAnnotation {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

extension Reusable where Self: MKMarkerAnnotationView {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

extension UICollectionView {
    
    func registerCell<T: Reusable>(
        for type: T.Type
    ) {
        register(
            UINib(nibName: type.reuseIdentifier, bundle: nil),
            forCellWithReuseIdentifier: type.reuseIdentifier
        )
    }
    
    enum CollectionViewSectionKind {
        case header
        case footer
        
        var supplementaryViewKind: String {
            switch self {
            case .header:
                return UICollectionView.elementKindSectionHeader
            case .footer:
                return UICollectionView.elementKindSectionFooter
            }
        }
    }
    
    func registerView<T: Reusable>(
        for type: T.Type,
        of kind: CollectionViewSectionKind
    ) {
        register(
            UINib(nibName: type.reuseIdentifier, bundle: nil),
            forSupplementaryViewOfKind: kind.supplementaryViewKind,
            withReuseIdentifier: type.reuseIdentifier
        )
    }
    
    func dequeueCell<T: Reusable>(
        for indexPath: IndexPath,
        with type: T.Type = T.self
    ) -> T {
        dequeueReusableCell(
            withReuseIdentifier: type.reuseIdentifier,
            for: indexPath
        ) as! T
    }
    
    func dequeueView<T: Reusable>(
        for indexPath: IndexPath,
        with type: T.Type = T.self,
        of kind: CollectionViewSectionKind
    ) -> T {
        dequeueReusableSupplementaryView(
            ofKind: kind.supplementaryViewKind,
            withReuseIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as! T
    }
}

extension Reusable where Self: UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

extension Reusable where Self: UITableViewHeaderFooterView {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

extension UITableView {
    func registerCell<T: Reusable>(
        with type: T.Type = T.self
    ) {
        register(
            UINib(nibName: type.reuseIdentifier, bundle: nil),
            forCellReuseIdentifier: type.reuseIdentifier
        )
    }
    
    func registerView<T: Reusable>(
        with type: T.Type = T.self
    ) {
        register(
            UINib(nibName: type.reuseIdentifier, bundle: nil),
            forHeaderFooterViewReuseIdentifier: type.reuseIdentifier
        )
    }
    
    func dequeueCell<T: Reusable>(
        for indexPath: IndexPath,
        with type: T.Type = T.self
    ) -> T {
        dequeueReusableCell(
            withIdentifier: type.reuseIdentifier,
            for: indexPath
        ) as! T
    }
    
    func dequeueView<T: Reusable>(
        with type: T.Type = T.self
    ) -> T {
        dequeueReusableHeaderFooterView(
            withIdentifier: T.reuseIdentifier
        ) as! T
    }
}

extension MKMapView {
    func registerAnnotationView<T: Reusable>(
        with type: T.Type = T.self
    ) where T: MKAnnotationView {
        register(
            T.self,
            forAnnotationViewWithReuseIdentifier: T.reuseIdentifier
        )
    }
    
    func dequeueAnnotationView<T: Reusable>(
        with type: T.Type = T.self,
        for annotation: MKAnnotation
    ) -> T {
        dequeueReusableAnnotationView(
            withIdentifier: T.reuseIdentifier,
            for: annotation
        ) as! T
    }
}
