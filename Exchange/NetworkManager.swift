//
//  NetworkManager.swift
//  Exchange
//
//  Created by Flávio Arêas on 31/12/24.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    private func endpoint(with path: String) -> String? {
        guard let key = ProcessInfo.processInfo.environment["KEY"] else { return nil }
        
        return "https://api.freecurrencyapi.com/v1/\(path)?apikey=\(key)"
    }
    
    public func getCurrencies() async throws -> [Currency] {        
        
        guard let endpoint = endpoint(with: "currencies"), let url = URL(string: endpoint) else {
            throw EXErrors.cantGetCurrencies
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw EXErrors.invalidResponse
        }
        
        do {
            let currencyResponse = try decoder.decode(CurrencyResponse.self, from: data)
            return convertCurrencyResponseToCurrencyArray(currencyResponse)
        } catch {
            throw EXErrors.invalidData
        }
    }
    
}
