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
    
    func testGetExchangeShouldPostFailedCallbackIfError() {
        // Given
        let exchangeService = ExchangeService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
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
        let exchangeService = ExchangeService(session: URLSessionFake(data: FakeResponseData.exchangeCorrectData, response: FakeResponseData.responseKO, error: nil))
        
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
        let exchangeService = ExchangeService(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        
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
        let exchangeService = ExchangeService(session: URLSessionFake(data: FakeResponseData.exchangeCorrectData, response: FakeResponseData.responseOK, error: nil))
        
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
}
