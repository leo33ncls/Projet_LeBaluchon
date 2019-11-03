//
//  CustomButton.swift
//  LeBaluchon
//
//  Created by Léo NICOLAS on 03/11/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        layer.bounds.size = CGSize(width: 160, height: 45)
        layer.cornerRadius = 10
    }
}
