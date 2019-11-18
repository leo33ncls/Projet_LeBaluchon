//
//  ExchangeServiceTestCase.swift
//  LeBaluchonTests
//
//  Created by Léo NICOLAS on 15/10/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

@testable import LeBaluchon
import XCTest

class ExchangeServiceTestCase: XCTestCase {
    let targetCurrency = "USD"

    //=====================
    // Test function getExchange

    func testGetExchangeShouldPostFailedCallbackIfError() {
        // Given
        let exchangeService = ExchangeService(session: URLSessionFake(data: nil,
                                                                      response: nil,
                                                                      error: FakeResponseData.error))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getExchange(targetCurrency: targetCurrency) { (success, exchange) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(exchange)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetExchangeShouldPostFailedCallbackIfNoData() {
        // Given
        let exchangeService = ExchangeService(session: URLSessionFake(data: nil, response: nil, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getExchange(targetCurrency: targetCurrency) { (success, exchange) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(exchange)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetExchangeShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let exchangeService = ExchangeService(session: URLSessionFake(data: FakeResponseData.exchangeCorrectData,
                                                                      response: FakeResponseData.responseKO,
                                                                      error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getExchange(targetCurrency: targetCurrency) { (success, exchange) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(exchange)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetExchangeShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let exchangeService = ExchangeService(session: URLSessionFake(data: FakeResponseData.incorrectData,
                                                                      response: FakeResponseData.responseOK,
                                                                      error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getExchange(targetCurrency: targetCurrency) { (success, exchange) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(exchange)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetExchangeShouldPostSuccesCallbackIfNoErrorAndCorrectData() {
        // Given
        let exchangeService = ExchangeService(session: URLSessionFake(data: FakeResponseData.exchangeCorrectData,
                                                                      response: FakeResponseData.responseOK,
                                                                      error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getExchange(targetCurrency: targetCurrency) { (success, exchange) in
            //Then
            let success = true
            let timestamp = 1570627447
            let base = "EUR"
            let date = "2019-10-09"
            let rates = ["USD": 1.09825]

            XCTAssertTrue(success)
            XCTAssertNotNil(exchange)

            XCTAssertEqual(success, exchange?.success)
            XCTAssertEqual(timestamp, exchange?.timestamp)
            XCTAssertEqual(base, exchange?.base)
            XCTAssertEqual(date, exchange?.date)
            XCTAssertEqual(rates, exchange?.rates)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    //=======================
    // Test function convertAmount

    func testGivenAmountEqual52AndExchangeRateEqual1Dot52_WhenConvertAmountIsCalled_ThenShouldReturn79Dot04() {
        // Given
        let amount = 52.0
        let exchangeRate = 1.52

        // When
        let convertedAmount = ExchangeService.convertAmount(amount: amount, exchangeRate: exchangeRate)

        // Then
        XCTAssertEqual(convertedAmount, 79.04)
    }

    func testGivenAmountEqua267Dot50AndExchangeRateEqual120Dot28_WhenConvertAmountIsCalled_ThenShouldReturn32174D90() {
        // Given
        let amount = 267.50
        let exchangeRate = 120.28

        // When
        let convertedAmount = ExchangeService.convertAmount(amount: amount, exchangeRate: exchangeRate)

        // Then
        XCTAssertEqual(convertedAmount, 32174.90)
    }

    func testGivenAmountEqual103Dot05AndExchangeRateEqual0Dot8587_WhenConvertAmountIsCalled_ThenShouldReturn88Dot49() {
        // Given
        let amount = 103.05
        let exchangeRate = 0.8587

        // When
        let convertedAmount = ExchangeService.convertAmount(amount: amount, exchangeRate: exchangeRate)

        // Then
        XCTAssertEqual(convertedAmount, 88.49)
    }
}
