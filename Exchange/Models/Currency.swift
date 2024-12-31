//
//  Currency.swift
//  Exchange
//
//  Created by Flávio Arêas on 31/12/24.
//

import Foundation

struct Currency: Codable {
    let symbol: String
    let name: String
    let symbolNative: String
    let decimalDigits: Int
    let rounding: Int
    let code: String
    let namePlural: String
    let type: String
}

struct CurrencyResponse: Codable {
    let data: [String: Currency]
}
