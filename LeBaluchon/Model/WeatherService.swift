//
//  WeatherService.swift
//  LeBaluchon
//
//  Created by Léo NICOLAS on 29/10/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import Foundation

class WeatherService {
    static var shared = WeatherService()
    private init() {}

    private static let weatherBaseUrl = "http://api.openweathermap.org/data/2.5/weather"
    private static let iconWeatherUrl = "http://openweathermap.org/img/wn/"

    private var task: URLSessionDataTask?

    private var weatherSession = URLSession(configuration: .default)
    private var imageWeatherSession = URLSession(configuration: .default)

    init(weatherSession: URLSession, imageWeatherSession: URLSession) {
        self.weatherSession = weatherSession
        self.imageWeatherSession = imageWeatherSession
    }

    private func createWeatherRequest(city: String) -> URLRequest {
        var weatherURL = URLComponents(string: WeatherService.weatherBaseUrl)!
        weatherURL.queryItems = [URLQueryItem(name: "q", value: city),
                                 URLQueryItem(name: "units", value: "metric"),
                                 URLQueryItem(name: "lang", value: "fr"),
                                 URLQueryItem(name: "APPID", value: keyWeatherAPI)]

        return URLRequest(url: weatherURL.url!)
    }

    func getWeather(city: String, callback: @escaping (Bool, Weather?, Data?) -> Void) {
        let request = createWeatherRequest(city: city)

        task = weatherSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil, nil)
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil, nil)
                    return
                }

                guard let weatherResponseJSON = try? JSONDecoder().decode(Weather.self, from: data) else {
                    callback(false, nil, nil)
                    return
                }

                self.getImage(icon: weatherResponseJSON.weather[0].icon, completionHandler: { (data) in
                    guard let iconData = data else {
                        callback(false, nil, nil)
                        return
                    }

                    callback(true, weatherResponseJSON, iconData)
                })
            }
        }
        task?.resume()
    }

    private func getImage(icon: String, completionHandler: @escaping (Data?) -> Void) {
        let iconUrl = URL(string: WeatherService.iconWeatherUrl + icon + "@2x.png")!

        let task = imageWeatherSession.dataTask(with: iconUrl) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return
                }
                completionHandler(data)
            }
        }
        task.resume()
    }

}
