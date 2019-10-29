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
    
    private static let exchangeURL = "http://data.fixer.io/api/latest"
    
    private var task: URLSessionDataTask?
    
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    private func createExchangeUrl() -> URL {
        let parameters = "&base=EUR&symbols=USD"
        
        return URL(string: ExchangeService.exchangeURL + keyExchangeAPI + parameters)!
    }
    
    func getExchange(callback: @escaping (Bool, ExchangeRate?) -> Void) {
        let url = createExchangeUrl()
        
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
                
                guard let responseJSON = try? JSONDecoder().decode(ExchangeRate.self, from: data) else {
                    callback(false, nil)
                    return
                }
                
                let exchange = responseJSON
                callback(true, exchange)
            }
        }
        task?.resume()
    }
    
}
