//
//  TableViewCell.swift
//  Market
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

    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var totalLabel: UILabel!
    
    func update(with model: TradeCellViewModel) {
        rateLabel.text = "\(model.rate)"
        amountLabel.text = "\(model.amount)"
        totalLabel.text = "\(model.total)"
    }
}
