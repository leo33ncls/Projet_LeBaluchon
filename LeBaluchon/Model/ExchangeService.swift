//
//  ExchangeService.swift
//  LeBaluchon
//
//  Created by Léo NICOLAS on 09/10/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import Foundation

class ExchangeService {
    static var shared = ExchangeService()
    private init() {}

    private static let exchangeBaseURL = "http://data.fixer.io/api/latest"

    private var task: URLSessionDataTask?

    private var session = URLSession(configuration: .default)

    init(session: URLSession) {
        self.session = session
    }

    private func createExchangeUrl(baseCurrency: String, targetCurrency: String) -> URL {
        var exchangeURL = URLComponents(string: ExchangeService.exchangeBaseURL)!
        exchangeURL.queryItems = [URLQueryItem(name: "base", value: baseCurrency),
                                  URLQueryItem(name: "symbols", value: targetCurrency),
                                  URLQueryItem(name: "access_key", value: keyExchangeAPI)]

        return exchangeURL.url!
    }

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

}
