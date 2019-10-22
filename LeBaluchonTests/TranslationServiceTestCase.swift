//
//  TranslationServiceTestCase.swift
//  LeBaluchonTests
//
//  Created by Léo NICOLAS on 22/10/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

@testable import LeBaluchon
import XCTest

class TranslationServiceTestCase: XCTestCase {

    func testGetTranslationShouldPostFailedCallbackIfError() {
        // Given
        let translationService = TranslationService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(textToTranslate: "Et c'est parti!") { (success, translation) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        // Given
        let translationService = TranslationService(session: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(textToTranslate: "Et c'est parti!") { (success, translation) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let translationService = TranslationService(session: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(textToTranslate: "Et c'est parti!") { (success, translation) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translationService = TranslationService(session: URLSessionFake(data: FakeResponseData.translationIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(textToTranslate: "Et c'est parti!") { (success, translation) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let translationService = TranslationService(session: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(textToTranslate: "Et c'est parti!") { (success, translation) in
            //Then
            let translatedText = "Here we go!"
            
            XCTAssertTrue(success)
            XCTAssertNotNil(translation)
            
            XCTAssertEqual(translatedText, translation?.data.translations[0].translatedText)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
