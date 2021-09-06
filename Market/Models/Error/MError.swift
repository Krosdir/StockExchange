//
//  MError.swift
//  Market
//
//  Created by Danil on 06.09.2021.
//

import Foundation

protocol MErrorKey {
    var rawValue: String { get }
}

enum MError: LocalizedError, Equatable {
    
    case custom(_ key: MErrorKey)
    case error(_ error: Error)
    
    private var descriptionKey: String {
        switch self {
        case .custom(let key):
            return key.rawValue
        case .error(let error):
            return error.localizedDescription
        }
    }
    
    var errorDescription: String? {
        descriptionKey.localized
    }
    
    static func == (lhs: MError, rhs: MError) -> Bool {
        return lhs.descriptionKey == rhs.descriptionKey
    }
}
