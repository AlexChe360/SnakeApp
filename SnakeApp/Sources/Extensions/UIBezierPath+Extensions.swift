//
//  UIBezierPath+Extensions.swift
//  SnakeApp
//
//  Created by  Alexey on 07.02.2024.
//

import UIKit

extension UIBezierPath {
    
    func isInsideBorder(_ pos:CGPoint, tolleranceWidth:CGFloat = 2.0)->Bool{
        let pathRef = cgPath.copy(strokingWithWidth: tolleranceWidth, lineCap: CGLineCap.butt, lineJoin: CGLineJoin.round, miterLimit: 0)
        let pathRefMutable = pathRef.mutableCopy()
        if let p = pathRefMutable {
            p.closeSubpath()
            return p.contains(pos)
        }
        return false
    }
    
    
    func interpolatePointsAlongPath() -> [CGPoint] {
        var allPoints: [CGPoint] = []
        
        self.cgPath.applyWithBlock { element in
            let points = element.pointee.points
            
            var interpolatedPoints: [CGPoint] = []
            
            switch element.pointee.type {
            case .moveToPoint:
                interpolatedPoints.append(points[0])
            case .addQuadCurveToPoint:
                let p0 = allPoints.last ?? CGPoint.zero
                let p1 = points[0]
                let p2 = points[1]
                interpolatedPoints += interpolateQuadCurve(p0: p0, p1: p1, p2: p2, resolution: 0.01)
            case .closeSubpath:
                break
            case .addLineToPoint:
                break
            case .addCurveToPoint:
                break
            @unknown default:
                break
            }
            
            allPoints += interpolatedPoints
        }
        
        var temp: CGPoint? = nil
        var distancedPoints: [CGPoint] = []
    
        allPoints.forEach {
            if temp != nil && temp!.distance(to: $0) >= 1.8  {
                distancedPoints.append($0)
                temp = $0
            }
            if temp == nil {
                temp = $0
            }
        }
        
        return distancedPoints
    }
    
    private func interpolateQuadCurve(p0: CGPoint, p1: CGPoint, p2: CGPoint, resolution: CGFloat) -> [CGPoint] {
        var points: [CGPoint] = []
        
        for t in stride(from: 0.0, through: 1.0, by: resolution){
            let x = (1-t)*(1-t)*p0.x + 2*(1-t)*t*p1.x + t*t*p2.x
            let y = (1-t)*(1-t)*p0.y + 2*(1-t)*t*p1.y + t*t*p2.y
            let point = CGPoint(x: x, y: y)
            if isInsideBorder(point) {
                points.append(point)
            }
        }
        
        return points
    }
}

