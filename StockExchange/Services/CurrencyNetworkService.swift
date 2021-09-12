//
//  CurrencyNetworkService.swift
//  StockExchange
//
//  Created by Danil on 12.09.2021.
//

import Foundation

final class CurrencyNetworkService: NetworkService {
    static let shared = CurrencyNetworkService()
    private override init() {}
    
    func getCurrencies(completion: @escaping (Result<[Currency], SEError>) -> Void) {
        let url = URL(string: "?command=returnCurrencies",
                      relativeTo: TradeHistoryNetworkService.basePublicURL)!
        
        let request = session.request(url,
                                      method: .get)

        request.validate().responseDecodable (
            of: [String: CurrencyData].self, decoder: decoder
        ) { (response) in
            completion(
                response.result
                    .map { $0.map({ Currency(from: $0.value) }) }
                    .mapError { _ in SEError(response.response?.statusCode) ?? .getCurrenciesFailed }
            )
        }
    }
}
