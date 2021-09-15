//
//  DisabledCurrencyTableViewCell.swift
//  StockExchange
//
//  Created by Danil on 13.09.2021.
//

import UIKit

struct DisabledCurrencyCellViewModel: UpdateableModel {
    let name: String
}

class DisabledCurrencyCollectionViewCell: UICollectionViewCell, UpdateableCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var cellView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }

    func update(with model: DisabledCurrencyCellViewModel) {
        nameLabel.text = model.name
    }
    
}

// MARK: - Private
private extension DisabledCurrencyCollectionViewCell {
    func setupViews() {
        DispatchQueue.main.async { [self] in
            let cornerRadius = cellView.frame.height / 2
            cellView.layer.cornerRadius = cornerRadius
            
            cellView.layer.shadowColor = UIColor.black.cgColor
            cellView.layer.shadowOffset = CGSize(width: 0, height: 2)
            cellView.layer.shadowRadius = 4
            cellView.layer.shadowPath = UIBezierPath(roundedRect: cellView.frame, cornerRadius: cornerRadius).cgPath
            cellView.layer.shadowOpacity = 0.7
        }
        
    }
}
