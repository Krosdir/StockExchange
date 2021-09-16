//
//  FrozenCurrencyCollectionViewCell.swift
//  StockExchange
//
//  Created by Danil on 15.09.2021.
//

import UIKit

struct FrozenCurrencyCellViewModel: UpdateableModel {
    let name: String
    let networkFee: Double
    let minAmount: Int
    let address: String?
}

class FrozenCurrencyCollectionViewCell: UICollectionViewCell, UpdateableCell {

    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var networkFeeLabel: UILabel!
    @IBOutlet private weak var minAmountLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    func update(with model: FrozenCurrencyCellViewModel) {
        nameLabel.text = model.name
        networkFeeLabel.text = "\(model.networkFee)"
        minAmountLabel.text = "\(model.minAmount)"
        addressLabel.text = model.address ?? "\"Empty\""
    }

}

// MARK: - Private
private extension FrozenCurrencyCollectionViewCell {
    enum FrozenConstants {
        static let cornerRadius: CGFloat = 5
        static let shadowRadius: CGFloat = 4
        static let shadowOpacity: Float = 0.7
        static let shadowOffset = CGSize(width: 0, height: 2)
    }
    
    func setupViews() {
        DispatchQueue.main.async { [self] in
            cellView.layer.cornerRadius = FrozenConstants.cornerRadius

            cellView.layer.shadowOffset = FrozenConstants.shadowOffset
            cellView.layer.shadowRadius = FrozenConstants.shadowRadius
            cellView.layer.shadowOpacity = FrozenConstants.shadowOpacity
            cellView.layer.shadowColor = UIColor.black.cgColor
            cellView.layer.shadowPath = UIBezierPath(roundedRect: cellView.frame,
                                                     cornerRadius: FrozenConstants.cornerRadius).cgPath
        }
        
    }
}
