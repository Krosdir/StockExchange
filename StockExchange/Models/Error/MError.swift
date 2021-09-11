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

extension MError {
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
    
    init(_ key: MErrorKey) {
        self = .custom(key)
    }
}

enum BaseErrorKey: String, MErrorKey {
    case authenticationFailed = "error.network.authentication.failed"
    case registrationFailed = "error.network.registration.failed"
    case permissionsDenied = "error.pemissions.denied"
    
    case requiredFieldsMissed = "error.required.fields.missed"
    
    case passwordEmpty = "error.login.password.empty"
    case emailEmpty = "error.login.email.empty"
    case emailInvalid = "error.login.email.invalid"
}

extension MError {
    static let authenticationFailed = MError(BaseErrorKey.authenticationFailed)
    static let registrationFailed = MError(BaseErrorKey.registrationFailed)
    static let permissionsDenied = MError(BaseErrorKey.permissionsDenied)
}

extension MError {
    static let requiredFieldsMissed = MError(BaseErrorKey.requiredFieldsMissed)
}

extension MError {
    static let passwordEmpty = MError(BaseErrorKey.passwordEmpty)
    static let emailEmpty = MError(BaseErrorKey.emailEmpty)
    static let emailInvalid = MError(BaseErrorKey.emailInvalid)
}

enum TradeErrorKey: String, MErrorKey {
    case getTradeHistory = "error.network.trade.history.get.failed"
}

extension MError {
    static let getTradeHistory = MError(TradeErrorKey.getTradeHistory)
}
