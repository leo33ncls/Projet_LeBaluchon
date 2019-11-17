//
//  TranslationViewController.swift
//  LeBaluchon
//
//  Created by Léo NICOLAS on 22/10/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {

    //===================
    // View Properties
    @IBOutlet weak var languageTranslationLabel: UILabel!
    @IBOutlet weak var textToTranslateTextView: UITextView!
    @IBOutlet weak var textTranslatedTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var translateButton: CustomButton!

    //===================
    // View Cycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        toggleActivityIndicator(shown: false)
        languageTranslationLabel.text =
        "Traduction en \(Parameters.languages[ParametersService.languageIndex].language)"
    }

    //===================
    // View Actions

    // An action which gets and displays the translation
    @IBAction func getTranslation(_ sender: UIButton) {
        toggleActivityIndicator(shown: true)

        if let textToTranslate = textToTranslateTextView.text {
            TranslationService.shared.getTranslation(targetLanguage: ParametersService.language,
                                                     textToTranslate: textToTranslate) { (success, translation) in
                self.toggleActivityIndicator(shown: false)

                if success, let translation = translation {
                    self.textTranslatedTextView.text = translation.data.translations[0].translatedText
                } else {
                    self.showAlert(title: "Erreur!", message: "Requête invalide!")
                }
            }
        } else {
            showAlert(title: "Attention!", message: "Veuillez saisir du texte!")
        }
    }

    //===================
    // View Functions

     // Function which manages the activityIndicator
    private func toggleActivityIndicator(shown: Bool) {
        translateButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }

    // Function which shows an alert
    private func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - Keyboard
extension TranslationViewController: UITextViewDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textToTranslateTextView.resignFirstResponder()
        textTranslatedTextView.resignFirstResponder()
    }
}
