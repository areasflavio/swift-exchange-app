//
//  EXConversions.swift
//  Exchange
//
//  Created by Flávio Arêas on 31/12/24.
//

import Foundation

func convertCurrencyResponseToCurrencyArray(_ response: CurrencyResponse) -> [Currency] {
    
    return response.data.map { (key, value) -> Currency in
        return value
    }.sorted { $0.code < $1.code }
}

func mapCurrenciesToPicker(_ currencies: [Currency]) -> [String] {
    
    return currencies.map { $0.code }
}
