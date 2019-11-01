//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by Léo NICOLAS on 29/10/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    
    @IBOutlet weak var secondCityNameLabel: UILabel!
    @IBOutlet weak var secondWeatherDescriptionLabel: UILabel!
    @IBOutlet weak var secondTemperatureLabel: UILabel!
    @IBOutlet weak var secondWeatherIconImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherService.shared.getWeather(city: "Bordeaux") { (success, weather, data) in
            if success, let weather = weather, let iconWeather = data {
                self.cityNameLabel.text = weather.name
                self.tempLabel.text = String(weather.main.temp) + " °C"
                self.weatherDescriptionLabel.text = weather.weather[0].weatherDescription
                self.weatherIconImageView.image = UIImage(data: iconWeather)
            } else {
                let alertVC = UIAlertController(title: "Erreur", message: "Requete Invalide", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            }
        }
        
        WeatherService.shared.getWeather(city: "Paris") { (success, weather, data) in
            if success, let weather = weather, let iconWeather = data {
                self.secondCityNameLabel.text = weather.name
                self.secondWeatherDescriptionLabel.text = weather.weather[0].weatherDescription
                self.secondTemperatureLabel.text = String(weather.main.temp) + " °C"
                self.secondWeatherIconImageView.image = UIImage(data: iconWeather)
            }
        }
    }
    
    @IBAction func pressedRefreshButton(_ sender: UIButton) {
        WeatherService.shared.getWeather(city: "Bordeaux") { (success, weather, data) in
            if success, let weather = weather, let iconWeather = data {
                self.cityNameLabel.text = weather.name
                self.tempLabel.text = String(weather.main.temp)
                self.weatherDescriptionLabel.text = weather.weather[0].weatherDescription
                self.weatherIconImageView.image = UIImage(data: iconWeather)
            } else {
                let alertVC = UIAlertController(title: "Erreur", message: "Requete Invalide", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            }
        }
    }
    
    
}
