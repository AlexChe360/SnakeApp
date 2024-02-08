//
//  CGPoint+Extensions.swift
//  SnakeApp
//
//  Created by  Alexey on 07.02.2024.
//

import UIKit

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow((point.x - x), 2) + pow((point.y - y), 2))
    }
    
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    var magnitude: CGFloat {
        return sqrt(x * x + y * y)
    }
}
