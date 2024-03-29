//
//  ExchangeService.swift
//  LeBaluchon
//
//  Created by Léo NICOLAS on 09/10/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import Foundation

class ExchangeService {
    // A unique instance of ExchangeService
    static var shared = ExchangeService()
    private init() {}

    private static let exchangeBaseURL = "http://data.fixer.io/api/latest"

    private var task: URLSessionDataTask?

    private var session = URLSession(configuration: .default)

    // An initializer which is used for the unit test
    init(session: URLSession) {
        self.session = session
    }

    // Function which creates an Url with parameters
    private func createExchangeUrl(baseCurrency: String, targetCurrency: String) -> URL {
        var exchangeURL = URLComponents(string: ExchangeService.exchangeBaseURL)!
        exchangeURL.queryItems = [URLQueryItem(name: "base", value: baseCurrency),
                                  URLQueryItem(name: "symbols", value: targetCurrency),
                                  URLQueryItem(name: "access_key", value: keyExchangeAPI)]

        return exchangeURL.url!
    }

    // Function which gets an objet ExchangeRate from a response request
    func getExchange(targetCurrency: String, callback: @escaping (Bool, ExchangeRate?) -> Void) {
        let url = createExchangeUrl(baseCurrency: "EUR", targetCurrency: targetCurrency)

        task?.cancel()
        task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }

                guard let exchangeResponseJSON = try? JSONDecoder().decode(ExchangeRate.self, from: data) else {
                    callback(false, nil)
                    return
                }

                callback(true, exchangeResponseJSON)
            }
        }
        task?.resume()
    }

    // Function which converts an amount
    static func convertAmount(amount: Double, exchangeRate: Double) -> Double {
        return roundAmount(amount: amount * exchangeRate)
    }

    // Function which rounds an amount
    private static func roundAmount(amount: Double) -> Double {
        return Double(round(100*amount)/100)
    }
}
