//
//  WeatherServiceTestCase.swift
//  LeBaluchonTests
//
//  Created by Léo NICOLAS on 29/10/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

@testable import LeBaluchon
import XCTest

class WeatherServiceTestCase: XCTestCase {

    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error),
            imageWeatherSession: URLSessionFake(data: nil, response: nil, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: "Bordeaux") { (success, weather, data) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            XCTAssertNil(data)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: nil),
            imageWeatherSession: URLSessionFake(data: nil, response: nil, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: "Bordeaux") { (success, weather, data) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            XCTAssertNil(data)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData,
                                           response: FakeResponseData.responseKO,
                                           error: nil),
            imageWeatherSession: URLSessionFake(data: nil, response: nil, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: "Bordeaux") { (success, weather, data) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            XCTAssertNil(data)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.incorrectData,
                                           response: FakeResponseData.responseOK,
                                           error: nil),
            imageWeatherSession: URLSessionFake(data: nil, response: nil, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: "Bordeaux") { (success, weather, data) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            XCTAssertNil(data)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData,
                                           response: FakeResponseData.responseOK,
                                           error: nil),
            imageWeatherSession: URLSessionFake(data: FakeResponseData.imageData,
                                                response: FakeResponseData.responseOK,
                                                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: "Bordeaux") { (success, weather, data) in
            // Then
            let temp = 19.32
            let weatherDescription = "overcast clouds"
            let humidity = 82
            let windSpeed = 1.5
            let cityName = "Bordeaux"

            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            XCTAssertNotNil(data)

            XCTAssertEqual(temp, weather?.main.temp)
            XCTAssertEqual(weatherDescription, weather?.weather[0].weatherDescription)
            XCTAssertEqual(humidity, weather?.main.humidity)
            XCTAssertEqual(windSpeed, weather?.wind.speed)
            XCTAssertEqual(cityName, weather?.name)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

}
