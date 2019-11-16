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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        languagePickerView.selectRow(ParametersService.languageIndex, inComponent: 0, animated: true)
        cityPickerView.selectRow(ParametersService.cityIndex, inComponent: 0, animated: true)
        currencySegmentedControl.selectedSegmentIndex = ParametersService.currencyIndex
    }

    @IBAction func saveButton(_ sender: Any) {
        saveCurrency()
        saveLanguage()
        saveCity()
    }

    private func saveCurrency() {
        switch currencySegmentedControl.selectedSegmentIndex {
        case 0:
            ParametersService.currencyIndex = 0
            ParametersService.currency = "USD"
        case 1:
            ParametersService.currencyIndex = 1
            ParametersService.currency = "GBP"
        case 2:
            ParametersService.currencyIndex = 2
            ParametersService.currency = "JPY"
        default:
            ParametersService.currencyIndex = 0
            ParametersService.currency = "USD"
        }
    }

    private func saveLanguage() {
        let languageIndex = languagePickerView.selectedRow(inComponent: 0)
        let language = Parameters.languages[languageIndex].code
        ParametersService.languageIndex = languageIndex
        ParametersService.language = language
    }

    private func saveCity() {
        let cityIndex = cityPickerView.selectedRow(inComponent: 0)
        let city = Parameters.cities[cityIndex]
        ParametersService.cityIndex = cityIndex
        ParametersService.city = city
    }
}

// MARK: - PickerView
extension ParameterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return Parameters.languages.count
        } else {
            return Parameters.cities.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return Parameters.languages[row].language
        } else {
            return Parameters.cities[row]
        }
    }
}
