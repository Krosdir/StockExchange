//
//  String.swift
//  StockExchange
//
//  Created by Danil on 06.09.2021.
//

import Foundation

extension String {
    var localized: String { NSLocalizedString(self, comment: "") }
    
    // Uses CommonCrypto library in BridgingHeader.h
    func sha512(key: String) -> String {
        //let CC_SHA512_DIGEST_LENGTH = 64
        let cKey = key.cString(using: String.Encoding.utf8)
        let cData = self.cString(using: String.Encoding.utf8)
        var result = [CUnsignedChar](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA512), cKey!, Int(strlen(cKey!)), cData!, Int(strlen(cData!)), &result)
        let hexBytes = result.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
}
