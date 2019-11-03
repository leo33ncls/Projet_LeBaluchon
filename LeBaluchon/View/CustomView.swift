//
//  CustomView.swift
//  LeBaluchon
//
//  Created by Léo NICOLAS on 03/11/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        layer.cornerRadius = 10
    }
}
