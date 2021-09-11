//
//  ActivityView.swift
//  ThriveHD
//
//  Created by veimer on 7/4/21.
//

import UIKit

final class ActivityView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    private func setup() {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.color = .white
        activityView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(activityView)
        activityView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        activityView.startAnimating()
        
        backgroundColor = .clear
    }
}
