//
//  Updateable.swift
//  ThriveHD
//
//  Created by veimer on 2/4/21.
//

import UIKit

protocol UpdateableModel { }

protocol Updateable {
    associatedtype ModelType: UpdateableModel
    
    func update(with model: ModelType)
}

protocol UpdateableCell: Updateable, Reusable { }
