//
//  FakeResponseData.swift
//  LeBaluchonTests
//
//  Created by Léo NICOLAS on 15/10/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//
// swiftlint:disable force_try

import Foundation

class FakeResponseData {
    // Variable which simulates a correct data response for the ExchangeService
    static var exchangeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "ExchangeRate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    // Variable which simulates a correct data response for the TranslationService
    static var translationCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    // Variable which simulates a correct data response for the WeatherService
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    // Variable which simulates an image data
    static let imageData = "image".data(using: .utf8)!

    // Variable which simulates an incorrect data
    static let incorrectData = "erreur".data(using: .utf8)!

    // Variable which simulates a OK response
    static let responseOK = HTTPURLResponse(url: URL(string: "https://")!,
                                            statusCode: 200,
                                            httpVersion: nil,
                                            headerFields: nil)!

    // Variable which simulates a KO response
    static let responseKO = HTTPURLResponse(url: URL(string: "https://")!,
                                            statusCode: 500,
                                            httpVersion: nil,
                                            headerFields: nil)!

    // Variable which simulates a request error
    class RequestError: Error {}
    static let error = RequestError()
}
