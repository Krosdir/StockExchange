//
//  TradeHistoryNetworkService.swift
//  StockExchange
//
//  Created by Danil on 11.09.2021.
//

import Foundation

final class TradeHistoryNetworkService: NetworkService {
    static let shared = TradeHistoryNetworkService()
    private override init() {}
    
    func getTradeHistory(for type: TradeHistoryType,
                         completion: @escaping (Result<[Trade], SEError>) -> Void) {
        let url = URL(string: "?command=returnTradeHistory&currencyPair=\(type.rawValue)",
                      relativeTo: TradeHistoryNetworkService.basePublicURL)!
        
        let request = session.request(url,
                                      method: .get)
        
        request.validate().responseDecodable (
            of: [TradeData].self, decoder: decoder
        ) { (response) in
            completion(
                response.result
                    .map { $0.map({ Trade(from: $0) }) }
                    .mapError { _ in SEError(response.response?.statusCode) ?? .getTradeHistoryFailed }
            )
        }
    }
}
