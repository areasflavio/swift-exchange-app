//
//  EXErrors.swift
//  Exchange
//
//  Created by Flávio Arêas on 31/12/24.
//

import Foundation

enum EXErrors: String, Error {
    case cantGetCurrencies = "Sorry, we can't get the available currencies. Please try again."
    case cantExchangeCurrencies = "Sorry, we can't exchange those currencies. Please try again."
    case invalidResponse = "Invalid reponse from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
