//
//  TradeTableViewHeader.swift
//  Market
//
//  Created by Danil on 11.09.2021.
//

import UIKit

protocol TradeTableViewSectionHeaderViewModelDelegate: AnyObject {
    func viewModelDidSelect(_ viewModel: TradeTableViewSectionHeaderViewModel)
}

struct TradeTableViewSectionHeaderViewModel {
    weak var delegate: TradeTableViewSectionHeaderViewModelDelegate?
    
    let type: TradeType
    
    init(type: TradeType) {
        self.type = type
    }
    
    func attemptsToSelectSection() {
        delegate?.viewModelDidSelect(self)
    }
}

class TradeTableViewSectionHeader: UITableViewHeaderFooterView, Reusable {
    @IBOutlet private weak var sectionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(with model: TradeTableViewSectionHeaderViewModel) {
        sectionLabel.text = model.type.rawValue.uppercased()
    }
}
