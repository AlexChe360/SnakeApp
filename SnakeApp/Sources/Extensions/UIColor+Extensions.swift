//
//  UIColor+Extensions.swift
//  SnakeApp
//
//  Created by  Alexey on 07.02.2024.
//

import UIKit

extension UIColor {
    
    static let magentoColor = UIColor(rgb: 0xE8078B)
    
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
