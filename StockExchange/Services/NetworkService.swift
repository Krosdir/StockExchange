//
//  MError.swift
//  StockExchange
//
//  Created by Danil on 09.09.2021.
//

import Foundation
import Alamofire

class NetworkService {
    static let basePublicLink = "https://poloniex.com/public"
    static let basePrivateLink = "https://poloniex.com/tradingApi"
    static var basePublicURL: URL { URL(string: "\(basePublicLink)")! }
    
    static let dateFormatter = ISO8601DateFormatter()
    
    private(set) lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    private(set) lazy var encoder: JSONParameterEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return JSONParameterEncoder(encoder: encoder)
    }()
    
    let session = Alamofire.Session.default
}
