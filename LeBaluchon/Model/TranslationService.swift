//
//  TranslationService.swift
//  LeBaluchon
//
//  Created by Léo NICOLAS on 22/10/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import Foundation

class TranslationService {
    static var shared = TranslationService()
    private init() {}
    
    private static let translationURL = URL(string: "http://")!
    
    private var task: URLSessionDataTask?
    
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    private func createTranslationRequest(textToTranslate: String) -> URLRequest {
        var request = URLRequest(url: TranslationService.translationURL)
        request.httpMethod = "POST"
        
        let sourceLanguage = "fr"
        let targetLanguage = "en"
        let textToTranslate = textToTranslate
        
        let body = """
        {
        "q": \(textToTranslate)
        "source": \(sourceLanguage)
        "target": \(targetLanguage)
        }
        """
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
    
    func getTranslation(textToTranslate: String, callback: @escaping (Bool, Translation?) -> Void) {
        let request = createTranslationRequest(textToTranslate: textToTranslate)
        
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
                
                guard let responseJSON = try? JSONDecoder().decode(Translation.self, from: data) else {
                    callback(false, nil)
                    return
                }
                
                let translation = responseJSON
                callback(true, translation)
            }
        }
        task?.resume()
    }
    
}
