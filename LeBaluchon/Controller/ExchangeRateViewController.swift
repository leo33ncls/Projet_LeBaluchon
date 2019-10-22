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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getExchange(_ sender: UIButton) {
        let amountToConvert = amountTextField.text
        
        if let amountTC = amountToConvert {
            if let amount = Double(amountTC) {
                let convertedAmount = amount * 1.2
                convertedAmountLabel.text = "\(convertedAmount) $"
            } else {
                showAlert(message: "Entrez un chiffre!")
            }
        } else {
            showAlert(message: "Veuillez entrer un montant!")
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
