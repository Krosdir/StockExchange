//
//  ProfileNetworkService.swift
//  StockExchange
//
//  Created by Danil on 19.09.2021.
//

import Alamofire
import Foundation

final class ProfileNetworkService: NetworkService {
    static let shared = ProfileNetworkService()
    private override init() {}
    
    func getCompleteBalances(completion: @escaping (Result<[CompleteBalance], SEError>) -> Void) {
        let body = "command=returnCompleteBalances&nonce=\(Date.epoch)"
        let sign = body.sha512(key: NetworkService.apiSecret)
        let url = URL(string: "?\(body)",
                      relativeTo: ProfileNetworkService.basePrivateURL)!
        let parameters = ["command": "returnCompleteBalances",
                          "nonce": "\(Date.epoch)"]
        
        let headers = HTTPHeaders([HTTPHeader(name: "Key", value: NetworkService.apiKey),
                                   HTTPHeader(name: "Sign", value: sign)])
        
        let request = session.request(url,
                                      method: .post,
                                      parameters: parameters,
                                      headers: headers)
        
        request.validate().responseDecodable (
            of: [String: BalancesData].self, decoder: decoder
        ) { (response) in
            completion(
                response.result
                    .map { $0.map({ CompleteBalance(currency: $0.key, balances: Balances(from: $0.value)) }) }
                    .mapError { _ in SEError(response.response?.statusCode) ?? .getCompleteBalancesFailed }
            )
        }
    }
    
    func getDepositAddresses(completion: @escaping (Result<[DepositAddress], SEError>) -> Void) {
        let body = "command=returnDepositAddresses&nonce=\(Date.epoch)"
        let sign = body.sha512(key: NetworkService.apiSecret)
        let url = URL(string: "?\(body)",
                      relativeTo: ProfileNetworkService.basePrivateURL)!
        let parameters = ["command": "returnDepositAddresses",
                          "nonce": "\(Date.epoch)"]
        
        let headers = HTTPHeaders([HTTPHeader(name: "Key", value: NetworkService.apiKey),
                                   HTTPHeader(name: "Sign", value: sign)])
        
        let request = session.request(url,
                                      method: .post,
                                      parameters: parameters,
                                      headers: headers)
        
        request.validate().responseDecodable (
            of: [String: String].self, decoder: decoder
        ) { (response) in
            completion(
                response.result
                    .map { $0.map({ DepositAddress(currency: $0.key, address: $0.value) }) }
                    .mapError { _ in SEError(response.response?.statusCode) ?? .getDepositAddressesFailed }
            )
        }
    }
}
