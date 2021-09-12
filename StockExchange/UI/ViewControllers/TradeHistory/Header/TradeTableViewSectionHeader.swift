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

class TradeTableViewSectionHeaderViewModel {
    weak var delegate: TradeTableViewSectionHeaderViewModelDelegate?
    
    let type: TradeType
    var isSelected: Bool = false
    
    init(type: TradeType) {
        self.type = type
    }
    
    func attemptsToSelectSection() {
        delegate?.viewModelDidSelect(self)
    }
}

class TradeTableViewSectionHeader: UITableViewHeaderFooterView, Reusable {
    @IBOutlet private weak var sectionView: UIView!
    @IBOutlet private weak var sectionLabel: UILabel!
    
    private var viewModel: TradeTableViewSectionHeaderViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }

    func update(with model: TradeTableViewSectionHeaderViewModel) {
        viewModel = model
        sectionLabel.text = model.type.rawValue.uppercased()
    }
}

// MARK: - Private
private extension TradeTableViewSectionHeader {
    func setupViews() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        sectionView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        viewModel?.attemptsToSelectSection()
    }
}
