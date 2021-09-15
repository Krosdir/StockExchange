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
    func setupViews() {
        DispatchQueue.main.async { [self] in
            let cornerRadius: CGFloat = 5
            cellView.layer.cornerRadius = cornerRadius
            
            cellView.layer.shadowColor = UIColor.black.cgColor
            cellView.layer.shadowOffset = CGSize(width: 0, height: 2)
            cellView.layer.shadowRadius = 4
            cellView.layer.shadowPath = UIBezierPath(roundedRect: cellView.frame, cornerRadius: cornerRadius).cgPath
            cellView.layer.shadowOpacity = 0.7
        }
        
    }
}
