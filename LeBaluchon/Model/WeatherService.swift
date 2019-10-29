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
    
    private static let weatherUrl = URL(string: "api.openweathermap.org/data/2.5/weather" + keyWeatherAPI)!
    
    private var task: URLSessionDataTask?
    
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    private func createWeatherRequest() -> URLRequest {
        var request = URLRequest(url: WeatherService.weatherUrl)
        request.httpMethod = "GET"
        
        let body = "?q=Bordeaux&units=metric"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
    
    func getWeather(callback: @escaping (Bool, Weather?) -> Void) {
        let request = createWeatherRequest()
        
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(Weather.self, from: data) else {
                    callback(false, nil)
                    return
                }
                
                let weather = responseJSON
                callback(true, weather)
            }
        }
        task?.resume()
    }
    
}
