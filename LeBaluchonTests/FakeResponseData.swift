//
//  FakeResponseData.swift
//  LeBaluchonTests
//
//  Created by Léo NICOLAS on 15/10/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import Foundation

class FakeResponseData {
    static var exchangeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "ExchangeRate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let exchangeIncorrectData = "erreur".data(using: .utf8)!
    
    static let responseOK = HTTPURLResponse(url: URL(string: "https://")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "https://")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class ExchangeError: Error {}
    static let error = ExchangeError()
}
