//
//  TranslationViewController.swift
//  LeBaluchon
//
//  Created by Léo NICOLAS on 22/10/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {
    @IBOutlet weak var languageTranslationLabel: UILabel!
    @IBOutlet weak var textToTranslateTextView: UITextView!
    @IBOutlet weak var textTranslatedTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var translateButton: CustomButton!

    var targetLanguage = "en"

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        toggleActivityIndicator(shown: false)
        targetLanguage = UserDefaults.standard.string(forKey: "language") ?? "en"
        languageTranslationLabel.text =
        "Traduction en \(Parameters.languages[UserDefaults.standard.integer(forKey: "languageIndex")].language)"
    }

    @IBAction func getTranslation(_ sender: UIButton) {
        let textToTranslate = textToTranslateTextView.text
        toggleActivityIndicator(shown: true)

        if let text = textToTranslate {
            TranslationService.shared.getTranslation(targetLanguage: targetLanguage,
                                                     textToTranslate: text) { (success, translation) in
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

    private func toggleActivityIndicator(shown: Bool) {
        translateButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }

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
