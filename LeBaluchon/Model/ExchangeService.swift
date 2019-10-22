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
    
    private static let exchangeURL = URL(string: "http://data.fixer.io/api/latest")!
    
    private var task: URLSessionDataTask?
    
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    func getExchange(callback: @escaping (Bool, ExchangeRate?) -> Void) {
        
        task?.cancel()
        task = session.dataTask(with: ExchangeService.exchangeURL) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(ExchangeRate.self, from: data) else {
                    callback(false, nil)
                    return
                }
                
                let exchange = ExchangeRate.init(success: responseJSON.success, timestamp: responseJSON.timestamp, base: responseJSON.base, date: responseJSON.date, rates: responseJSON.rates)
                callback(true, exchange)
            }
        }
        task?.resume()
    }
    
}
