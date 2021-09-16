//
//  DelistedCollectionReusableView.swift
//  StockExchange
//
//  Created by Danil on 14.09.2021.
//

import UIKit

struct DelistedCurrencyCellViewModel: UpdateableModel {
    let id: Int
    let name: String
}

class DelistedCurrencyCollectionViewCell: UICollectionViewCell, UpdateableCell {
    
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    func update(with model: DelistedCurrencyCellViewModel) {
        idLabel.text = "\(model.id)"
        nameLabel.text = model.name
    }
}

// MARK: - Private
private extension DelistedCurrencyCollectionViewCell {
    enum DelistedConstants {
        static let cornerRadius: CGFloat = 5
        static let shadowRadius: CGFloat = 4
        static let shadowOpacity: Float = 0.7
        static let shadowOffset = CGSize(width: 0, height: 2)
    }
    
    func setupViews() {
        DispatchQueue.main.async { [self] in
            cellView.layer.cornerRadius = DelistedConstants.cornerRadius
            
            cellView.layer.shadowOffset = DelistedConstants.shadowOffset
            cellView.layer.shadowRadius = DelistedConstants.shadowRadius
            cellView.layer.shadowOpacity = DelistedConstants.shadowOpacity
            cellView.layer.shadowColor = UIColor.black.cgColor
            cellView.layer.shadowPath = UIBezierPath(roundedRect: cellView.frame,
                                                     cornerRadius: DelistedConstants.cornerRadius).cgPath
        }
        
    }
}
