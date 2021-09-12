//
//  MError.swift
//  Market
//
//  Created by Danil on 06.09.2021.
//

import Foundation

protocol SEErrorKey {
    var rawValue: String { get }
}

enum SEError: LocalizedError, Equatable {
    
    case custom(_ key: SEErrorKey)
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
    
    static func == (lhs: SEError, rhs: SEError) -> Bool {
        return lhs.descriptionKey == rhs.descriptionKey
    }
}

extension SEError {
    init?(_ code: Int?) {
        switch code {
        case 401:
            self = .authenticationFailed
        case 403:
            self = .permissionsDenied
        default:
            return nil
        }
    }
    
    init(_ key: SEErrorKey) {
        self = .custom(key)
    }
}

enum BaseErrorKey: String, SEErrorKey {
    case authenticationFailed = "error.network.authentication.failed"
    case registrationFailed = "error.network.registration.failed"
    case permissionsDenied = "error.pemissions.denied"
    
    case requiredFieldsMissed = "error.required.fields.missed"
    
    case passwordEmpty = "error.login.password.empty"
    case emailEmpty = "error.login.email.empty"
    case emailInvalid = "error.login.email.invalid"
}

extension SEError {
    static let authenticationFailed = SEError(BaseErrorKey.authenticationFailed)
    static let registrationFailed = SEError(BaseErrorKey.registrationFailed)
    static let permissionsDenied = SEError(BaseErrorKey.permissionsDenied)
}

extension SEError {
    static let requiredFieldsMissed = SEError(BaseErrorKey.requiredFieldsMissed)
}

extension SEError {
    static let passwordEmpty = SEError(BaseErrorKey.passwordEmpty)
    static let emailEmpty = SEError(BaseErrorKey.emailEmpty)
    static let emailInvalid = SEError(BaseErrorKey.emailInvalid)
}

enum TradeErrorKey: String, SEErrorKey {
    case getTradeHistory = "error.network.trade.history.get.failed"
}

extension SEError {
    static let getTradeHistoryFailed = SEError(TradeErrorKey.getTradeHistory)
}

enum CurrencyErrorKey: String, SEErrorKey {
    case getCurrenciesFailed = "error.network.currency.get.failed"
}

extension SEError {
    static let getCurrenciesFailed = SEError(CurrencyErrorKey.getCurrenciesFailed)
}
