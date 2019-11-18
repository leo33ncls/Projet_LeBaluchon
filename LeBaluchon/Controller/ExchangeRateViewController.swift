//
//  ExchangeRateViewController.swift
//  LeBaluchon
//
//  Created by Léo NICOLAS on 08/10/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {

    //===================
    // View Properties
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var convertedAmountLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var convertButton: CustomButton!

    //===================
    // View Cycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        toggleActivityIndicator(shown: false)
        convertedAmountLabel.text = "Montant en " + showCurrencySymbol()
    }

    //===================
    // View Actions

    // An action which gets and displays an exchange
    @IBAction func getExchange(_ sender: UIButton) {

        guard let amountString = amountTextField.text else {
            return showAlert(message: "Veuillez entrer un montant!") }

        guard let amountToConvert = Double(amountString) else {
            return showAlert(message: "Entrez un nombre!") }
        toggleActivityIndicator(shown: true)

        ExchangeService.shared.getExchange(targetCurrency: ParametersService.currency) { (success, exchange) in
            self.toggleActivityIndicator(shown: false)

            if success, let exchange = exchange {
                guard let exchangeRate = exchange.rates[ParametersService.currency] else {
                    return self.showAlert(message: "Devise Incorrect") }
                let convertedAmount = ExchangeService.convertAmount(amount: amountToConvert, exchangeRate: exchangeRate)
                self.convertedAmountLabel.text = String(convertedAmount) + self.showCurrencySymbol()
            } else {
                self.showAlert(message: "Requête Invalide!")
            }
        }
    }

    //===================
    // View Functions

    // Function which shows the good currency symbol from the parameter currency
    private func showCurrencySymbol() -> String {
        switch ParametersService.currency {
        case "USD": return "$"
        case "GBP": return "£"
        case "JPY": return "¥"
        default:
            return " $"
        }
    }

    // Function which manages the activityIndicator
    private func toggleActivityIndicator(shown: Bool) {
        convertButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }

    // Function which shows an alert
    private func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Attention!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - Keyboard
extension ExchangeRateViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        amountTextField.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
