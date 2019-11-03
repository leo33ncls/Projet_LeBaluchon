//
//  ParameterViewController.swift
//  LeBaluchon
//
//  Created by Léo NICOLAS on 02/11/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class ParameterViewController: UIViewController {
    
    @IBOutlet weak var languagePickerView: UIPickerView!
    @IBOutlet weak var cityPickerView: UIPickerView!
    @IBOutlet weak var currencySegmentedControl: UISegmentedControl!
    
    @IBAction func saveButton(_ sender: Any) {
        switch currencySegmentedControl.selectedSegmentIndex {
        case 0: UserDefaults.standard.set("USD", forKey: "currency")
        case 1: UserDefaults.standard.set("GBP", forKey: "currency")
        case 2: UserDefaults.standard.set("JPY", forKey: "currency")
        default:
            UserDefaults.standard.set("USD", forKey: "currency")
        }
        
        let languageIndex = languagePickerView.selectedRow(inComponent: 0)
        let language = languages[languageIndex].code
        UserDefaults.standard.set(languageIndex, forKey: "languageIndex")
        UserDefaults.standard.set(language, forKey: "language")
        
        let cityIndex = cityPickerView.selectedRow(inComponent: 0)
        let city = cities[cityIndex]
        UserDefaults.standard.set(city, forKey: "city")
        
        UserDefaults.standard.synchronize()
    }
    
}

// MARK: - PickerView
extension ParameterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return languages.count
        } else {
            return cities.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return languages[row].language
        } else {
            return cities[row]
        }
    }
}
