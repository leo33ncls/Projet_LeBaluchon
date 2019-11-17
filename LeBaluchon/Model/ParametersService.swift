//
//  ParametersService.swift
//  LeBaluchon
//
//  Created by Léo NICOLAS on 13/11/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import Foundation

class ParametersService {
    // The ParametersService Keys
    struct Keys {
        static let currencyIndex = "currencyIndex"
        static let currency = "currency"
        static let languageIndex = "languageIndex"
        static let language = "language"
        static let cityIndex = "cityIndex"
        static let city = "city"
    }

    // The variable which saves the index of the parameter currency
    static var currencyIndex: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.currencyIndex)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.currencyIndex)
        }
    }

    // The variable which saves the parameter currency
    static var currency: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.currency) ?? "USD"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.currency)
        }
    }

    // The variable which saves the index of the parameter language
    static var languageIndex: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.languageIndex)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.languageIndex)
        }
    }

    // The variable which saves the parameter language
    static var language: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.language) ?? "en"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.language)
        }
    }

    // The variable which saves the index of the parameter city
    static var cityIndex: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.cityIndex)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.cityIndex)
        }
    }

    // The variable which saves the parameter city
    static var city: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.city) ?? "New York"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.city)
        }
    }
}
