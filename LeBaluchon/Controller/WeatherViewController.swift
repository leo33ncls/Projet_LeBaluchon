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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var refreshButton: CustomButton!
    
    var city = "New York"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        city = UserDefaults.standard.string(forKey: "city") ?? "New York"
        
        toggleActivityIndicator(shown: false)
        showFirstWeather()
        showSecondWeather(city: city)
    }
    
    @IBAction func pressedRefreshButton(_ sender: UIButton) {
        toggleActivityIndicator(shown: true)
        showFirstWeather()
        showSecondWeather(city: city)
    }
    
    private func showFirstWeather() {
        WeatherService.shared.getWeather(city: "Bordeaux") { (success, weather, icon) in
            self.toggleActivityIndicator(shown: false)
            
            if success, let weather = weather, let iconWeather = icon {
                self.cityNameLabel.text = weather.name
                self.tempLabel.text = String(weather.main.temp) + " °C"
                self.weatherDescriptionLabel.text = weather.weather[0].weatherDescription
                self.weatherIconImageView.image = UIImage(data: iconWeather)
            } else {
                self.showAlert(title: "Erreur", message: "Une erreur est survenue!")
            }
        }
    }
    
    private func showSecondWeather(city: String) {
        WeatherService.shared.getWeather(city: city) { (success, weather, icon) in
            self.toggleActivityIndicator(shown: false)
            
            if success, let weather = weather, let iconWeather = icon {
                self.secondCityNameLabel.text = weather.name
                self.secondTemperatureLabel.text = String(weather.main.temp) + " °C"
                self.secondWeatherDescriptionLabel.text = weather.weather[0].weatherDescription
                self.secondWeatherIconImageView.image = UIImage(data: iconWeather)
            } else {
                self.showAlert(title: "Erreur", message: "Une erreur est survenue!")
            }
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        refreshButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }
    
    private func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
