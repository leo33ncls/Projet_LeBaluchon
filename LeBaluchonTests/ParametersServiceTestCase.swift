//
//  ParametersServiceTestCase.swift
//  LeBaluchonTests
//
//  Created by Léo NICOLAS on 15/11/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

@testable import LeBaluchon
import XCTest

class ParametersServiceTestCase: XCTestCase {

    // PS = ParametersService
    func testGivenPSCurrencyHasNoValue_WhenValueOfPSCurrencyIsUsed_ThenPSCurrencyShouldReturnUSD() {
        // Given
        UserDefaults.standard.removeObject(forKey: ParametersService.Keys.currency)

        // When
        let currency = ParametersService.currency

        // Then
        XCTAssertEqual(currency, "USD")
    }

    func testGivenPSLanguageHasNoValue_WhenValueOfPSLanguageIsUsed_ThenPSLanguageShouldReturnEn() {
        UserDefaults.standard.removeObject(forKey: ParametersService.Keys.language)

        let language = ParametersService.language

        XCTAssertEqual(language, "en")
    }

    func testGivenPSCityHasNoValue_WhenValueOfPSCityIsUsed_ThenPSCityShouldReturnNewYork() {
        UserDefaults.standard.removeObject(forKey: ParametersService.Keys.city)

        let city = ParametersService.city

        XCTAssertEqual(city, "New York")
    }

    func testGivenCurrencyIndexEqualOne_WhenPSCurrencyIndexSaveCurrencyIndex_ThenPSCurrencyIndexShouldReturnOne() {
        // Given
        let currencyIndex = 1

        // When
        ParametersService.currencyIndex = currencyIndex

        // Then
        XCTAssertEqual(ParametersService.currencyIndex, 1)
    }

    func testGivenCurrencyEqualGBY_WhenPSCurrencySaveCurrency_ThenPSCurrencyShouldReturnGBY() {
        let currency = "GBY"

        ParametersService.currency = currency

        XCTAssertEqual(ParametersService.currency, "GBY")
    }

    func testGivenLangIndexEqualThree_WhenPSLanguageSaveLanguageWithValueOfLangIndex_ThenPSLanguageShouldReturnEs() {
        // Given
        let languageIndex = 3
        let languageCode = Parameters.languages[languageIndex].code

        // When
        ParametersService.languageIndex = languageIndex
        ParametersService.language = languageCode

        // Then
        XCTAssertEqual(ParametersService.languageIndex, 3)
        XCTAssertEqual(ParametersService.language, "es")
    }

    func testGivenCityIndexEqualNine_WhenPSCitySaveCityWithValueOfCityIndex_ThenPSCityShouldReturnLondon() {
        let cityIndex = 9
        let city = Parameters.cities[cityIndex]

        ParametersService.cityIndex = cityIndex
        ParametersService.city = city

        XCTAssertEqual(ParametersService.cityIndex, 9)
        XCTAssertEqual(ParametersService.city, "London")
    }
}
