//
//  ExchangeRateViewController.swift
//  LeBaluchon
//
//  Created by Léo NICOLAS on 08/10/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var convertedAmountLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var convertButton: CustomButton!
    
    var targetCurrency = "USD"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        toggleActivityIndicator(shown: false)
        targetCurrency = UserDefaults.standard.string(forKey: "currency") ?? "USD"
        convertedAmountLabel.text = "Montant en" + showCurrencySymbol()
    }
    
    @IBAction func getExchange(_ sender: UIButton) {
        let amountToConvert = amountTextField.text
        
        guard let amountTC = amountToConvert else { return showAlert(message: "Veuillez entrer un montant!") }
        guard let amount = Double(amountTC) else { return showAlert(message: "Entrez un chiffre!") }
        toggleActivityIndicator(shown: true)
        
        ExchangeService.shared.getExchange(targetCurrency: targetCurrency) { (success, exchange) in
            self.toggleActivityIndicator(shown: false)
            
            if success, let exchange = exchange {
                guard let exchangeRate = exchange.rates[self.targetCurrency] else { return self.showAlert(message: "Devise Incorrect")}
                let convertedAmount = amount * exchangeRate
                self.convertedAmountLabel.text = String(convertedAmount) + self.showCurrencySymbol()
            } else {
                self.showAlert(message: "Requête Invalide!")
            }
        }
    }
    
    private func showCurrencySymbol() -> String {
        switch targetCurrency {
        case "USD": return " $"
        case "GBP": return " £"
        case "JPY": return " ¥"
        default:
            return "$"
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        convertButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }
    
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
