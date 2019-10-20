//
//  ExchangeRate.swift
//  LeBaluchon
//
//  Created by Léo NICOLAS on 20/10/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import Foundation

struct ExchangeRate: Codable {
    var success: Bool
    var timestamp: Int
    var base: String
    var date: String
    var rates: [String : Double]
}
