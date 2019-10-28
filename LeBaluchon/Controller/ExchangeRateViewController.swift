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
    
    
    @IBAction func getExchange(_ sender: UIButton) {
        let amountToConvert = amountTextField.text
        
        guard let amountTC = amountToConvert else { return showAlert(message: "Veuillez entrer un montant!") }
        guard let amount = Double(amountTC) else { return showAlert(message: "Entrez un chiffre!") }
        
        ExchangeService.shared.getExchange { (success, exchange) in
            if success, let exchange = exchange {
                let convertedAmount = amount * exchange.rates["USD"]!
                self.convertedAmountLabel.text = String(convertedAmount)
            } else {
                self.showAlert(message: "Requête Invalide!")
            }
        }
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
