//
//  TranslationService.swift
//  LeBaluchon
//
//  Created by Léo NICOLAS on 22/10/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import Foundation

class TranslationService {
    // A unique instance of TranslationService
    static var shared = TranslationService()
    private init() {}

    private static let translationBaseURL = "https://translation.googleapis.com/language/translate/v2"

    private var task: URLSessionDataTask?

    private var session = URLSession(configuration: .default)

    // An initializer which is used for the unit test
    init(session: URLSession) {
        self.session = session
    }

     // Function which creates an request to get a translation
    private func createTranslationRequest(sourceLanguage: String,
                                          targetLanguage: String,
                                          textToTranslate: String) -> URLRequest {

        var urlComponents = URLComponents(string: TranslationService.translationBaseURL)!
        urlComponents.queryItems = [URLQueryItem(name: "key", value: keyTranslationAPI)]

        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = """
        {
        "q": "\(textToTranslate)",
        "source": "\(sourceLanguage)",
        "target": "\(targetLanguage)",
        "format": "text"
        }
        """
        request.httpBody = body.data(using: .utf8)

        return request
    }

    // Function which gets an objet Translation from a response request
    func getTranslation(targetLanguage: String,
                        textToTranslate: String,
                        callback: @escaping (Bool, Translation?) -> Void) {

        let request = createTranslationRequest(sourceLanguage: "fr",
                                               targetLanguage: targetLanguage,
                                               textToTranslate: textToTranslate)

        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }

                guard let translationResponseJSON = try? JSONDecoder().decode(Translation.self, from: data) else {
                    callback(false, nil)
                    return
                }

                callback(true, translationResponseJSON)
            }
        }
        task?.resume()
    }

}
