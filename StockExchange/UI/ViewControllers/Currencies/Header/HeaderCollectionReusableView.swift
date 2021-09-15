//
//  HeaderCollectionReusableView.swift
//  StockExchange
//
//  Created by Danil on 13.09.2021.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView, Reusable {

    @IBOutlet private weak var titleLabel: UILabel!
    
    func setTitle(with text: String) {
        titleLabel.text = text.uppercased()
    }
    
}
