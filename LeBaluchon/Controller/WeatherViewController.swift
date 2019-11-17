//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by Léo NICOLAS on 29/10/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    //===================
    // View Properties
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

    //===================
    // View Cycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        toggleActivityIndicator(shown: false)
        showFirstWeather()
        showSecondWeather(city: ParametersService.city)
    }

    //===================
    // View Actions

    // Action which refreshes the weather
    @IBAction func pressedRefreshButton(_ sender: UIButton) {
        toggleActivityIndicator(shown: true)
        showFirstWeather()
        showSecondWeather(city: ParametersService.city)
    }

    //===================
    // View Functions

    // Function which gets and displays the first city's weather
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

     // Function which gets and displays the second city's weather
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

     // Function which manages the activityIndicator
    private func toggleActivityIndicator(shown: Bool) {
        refreshButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }

    // Function which shows an alert
    private func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
