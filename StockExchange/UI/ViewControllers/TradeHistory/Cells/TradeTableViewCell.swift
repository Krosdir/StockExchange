//
//  TableViewCell.swift
//  StockExchange
//
//  Created by Danil on 11.09.2021.
//

import UIKit

struct TradeCellViewModel: UpdateableModel {
    let rate: Double
    let amount: Double
    let total: Double
}

class TradeTableViewCell: UITableViewCell, UpdateableCell {

    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var totalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }
    
    func update(with model: TradeCellViewModel) {
        rateLabel.text = "\(model.rate)"
        amountLabel.text = "\(model.amount)"
        totalLabel.text = "\(model.total)"
    }
}

// MARK: - Private
private extension TradeTableViewCell {
    enum TradeConstants {
        static let borderWidth: CGFloat = 0.5
    }
    
    func setupViews() {
        cellView.layer.borderWidth = TradeConstants.borderWidth
        cellView.layer.borderColor = UIColor.brighterDark.cgColor
    }
}
