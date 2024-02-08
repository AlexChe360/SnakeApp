//
//  SnakeView.swift
//  SnakeApp
//
//  Created by  Alexey on 07.02.2024.
//

import UIKit

class SnakeView: UIView {
    
    private let path = UIBezierPath()
    private let shapeLayer = CAShapeLayer()
    private var imageViewFlag: UIImageView!
    private var pathViewFlag: UIView!
    private var imageViewCastle: UIImageView!
    private var pathViewCastle: UIView!
    private var imageViewHorse: UIImageView!
    private var pathViewHourse: UIView!
    private var hourseIsDone: Bool = false
    private var max: Int? = nil
    private var positions: Array<Int>? = nil
    private var currentPosition: Int? = nil
    private var pressingPoint: CGPoint? = nil
    private var flagSelector: ((Int) -> Void)?
    private var width: CGFloat = 0.0
    private var height: CGFloat = 0.0
    
    var isFinesh: Bool = false {
        didSet {
            hourseIsDone = isFinesh
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        if max != nil {
            pressingPoint = CGPoint(x: point.x, y: point.y)
            setNeedsDisplay()
        }
        
        return true
    }
    
    override func draw(_ rect: CGRect) {
        
        width = rect.width
        height = rect.height
        
        path.move(to: CGPoint(x: width * 0.5185185, y: height * 0.7638554))
        path.addQuadCurve(to: CGPoint(x: width * 0.33333334, y: height * 0.72096384), controlPoint: CGPoint(x: width * 0.53518516, y: height * 0.7180723))
        path.addQuadCurve(to: CGPoint(x: width * 0.14814815, y: height * 0.7151807), controlPoint: CGPoint(x: width * 0.19444445, y: height * 0.72385544))
        path.addQuadCurve(to: CGPoint(x: width * 0.16203703, y: height * 0.6713253), controlPoint: CGPoint(x: width * 0.1037037, y: height * 0.7060241))
        path.addQuadCurve(to: CGPoint(x: width * 0.5185185, y: height * 0.6438554), controlPoint: CGPoint(x: width * 0.24074075, y: height * 0.6279518))
        path.addQuadCurve(to: CGPoint(x: width * 0.7962963, y: height * 0.65638554), controlPoint: CGPoint(x: width * 0.7314815, y: height * 0.6578313))
        path.addQuadCurve(to: CGPoint(x: width * 0.8240741, y: height * 0.60722893), controlPoint: CGPoint(x: width * 0.90555555, y: height * 0.65301204))
        path.addQuadCurve(to: CGPoint(x: width * 0.35185185, y: height * 0.5421687), controlPoint: CGPoint(x: width * 0.75, y: height * 0.5710843))
        path.addQuadCurve(to: CGPoint(x: width * 0.16666667, y: height * 0.4486747), controlPoint: CGPoint(x: width * -0.03888889, y: height * 0.51421684))
        path.addQuadCurve(to: CGPoint(x: width * 0.6111111, y: height * 0.41108432), controlPoint: CGPoint(x: width * 0.28703704, y: height * 0.41686746))
        path.addQuadCurve(to: CGPoint(x: width * 0.7962963, y: height * 0.3633735), controlPoint: CGPoint(x: width * 0.9592593, y: height * 0.40722892))
        path.addQuadCurve(to: CGPoint(x: width * 0.42592594, y: height * 0.35036144), controlPoint: CGPoint(x: width * 0.7268519, y: height * 0.34843373))
        path.addQuadCurve(to: CGPoint(x: width * 0.14814815, y: height * 0.3146988), controlPoint: CGPoint(x: width * 0.21296297, y: height * 0.35180724))
        path.addQuadCurve(to: CGPoint(x: width * 0.1388889, y: height * 0.2626506), controlPoint: CGPoint(x: width * 0.12037037, y: height * 0.29638556))
        path.addQuadCurve(to: CGPoint(x: width * 0.35185185, y: height * 0.24096386), controlPoint: CGPoint(x: width * 0.16666667, y: height * 0.19518073))
        path.addQuadCurve(to: CGPoint(x: width * 0.73703706, y: height * 0.26409638), controlPoint: CGPoint(x: width * 0.63148147, y: height * 0.31325302))
        
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 4.0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        layer.addSublayer(shapeLayer)
        
        
        drawScene()
        
        
    }
    
    func showFlags(positions: Array<Int>, max: Int, currentPosition: Int) {
        
        self.positions = positions
        self.max = max
        self.currentPosition = currentPosition
        
        pathViewFlag = UIView(frame: CGRect(x: 0, y: 0, width: width * 0.08, height: width * 0.08))
        //addSubview(pathViewFlag)
        
        pathViewCastle = UIView(frame: CGRect(x: 0, y: 0, width: width * 0.08, height: width * 0.08))
       // addSubview(pathViewCastle)
        
        pathViewHourse = UIView(frame: CGRect(x: 0, y: 0, width: width * 0.08, height: width * 0.08))
       // addSubview(pathViewHourse)
        
    }
    
    private func drawScene() {
        
        let pathPoints = path.interpolatePointsAlongPath()
        let endPoint = pathPoints.last!
        let startPoint = pathPoints.first!
        
        drawFirstAndLastPoint(endPoint: endPoint, startPoint: startPoint)
        
        pathPoints.enumerated().forEach {
            
            let pointsSize = pathPoints.count - 1
            let pointIndex = $0.offset
            let point = $0.element
            
            if max == 0 {
                return
            }
            
            guard let currentPosition = self.currentPosition else { return }
            guard let max = self.max else { return }
            
            let currentRatio = Double(currentPosition) / Double(max)
            let currentIndex = Int(Double(pointsSize) * currentRatio)
            
            if $0.offset <= currentIndex {
                drawLine(color: UIColor.magentoColor, x: point.x, y: point.y)
            }
            
            if pointIndex == currentIndex {
                let lineRatio = (1.0 / Double(pointsSize)) * Double(pointIndex)
                let isFlippedPosition = isFlippedPosition(ratio: Float(lineRatio))
                let hoursePos = getHoursePosition(ratio: lineRatio, x: point.x, y: point.y)
                let valuePos = getValuePosition(ratio: lineRatio, x: point.x, y: point.y)
                
                
                if currentPosition == max {
                    isFinesh = true
                    drawPoint(color: UIColor.magentoColor, x: endPoint.x, y: endPoint.y)
                } else {
                    isFinesh = false
                }
                
                drawCastle(x: endPoint.x, y: endPoint.y, value: String(max), isDone: hourseIsDone)
                
                if currentPosition == 0 {
                    drawHorse(color: UIColor.black, x: point.x, y: point.y, isFlippedPosition: isFlippedPosition, value: String(currentPosition), isDone: true, positionHorse: hoursePos, valuePosition: valuePos)
                } else {
                    drawHorse(color: UIColor.black, x: point.x, y: point.y, isFlippedPosition: isFlippedPosition, value: String(currentPosition), isDone: hourseIsDone, positionHorse: hoursePos, valuePosition: valuePos)
                }
            }
            
            positions?.forEach {
                
                let ratio = Double($0) / Double(max)
                let flagIndex = Int(Double(pointsSize) * ratio)
                
                if flagIndex == pointIndex && pointIndex < pointsSize {
                    
                    let flagPoint = getFlagPoint(point: point, ratio: ratio)
                    
                    callSelectorFromPressing(pos: (flagIndex, flagPoint), size: Int(width * 0.07))
                    
                    drawFlag(name: "flag", x: flagPoint.x, y: flagPoint.y, value: String($0))
                    drawPoint(color: UIColor.lightGray, x: point.x, y: point.y)
                    
                    if pointIndex <= currentIndex {
                        drawPoint(color: UIColor.magentoColor, x: point.x, y: point.y)
                        drawPoint(color: UIColor.magentoColor, x: startPoint.x, y: startPoint.y)
                        drawFlag(name: "green_flag", x: flagPoint.x, y: flagPoint.y)
                    } else if pointIndex > 0 {
                        drawPoint(color: UIColor.magentoColor, x: startPoint.x, y: startPoint.y)
                    } else if pointIndex >= max {
                        drawPoint(color: UIColor.magentoColor, x: endPoint.x, y: endPoint.y)
                    }
                }
            }
        }
    }
    
    private func callSelectorFromPressing(pos: (Int, CGPoint), size: Int) {
        if let pressed = pressingPoint {
            print("pressed: \(pressed)")
            if pressed.x > pos.1.x && pressed.x < pos.1.x + CGFloat(size)
                && pressed.y > pos.1.y && pressed.y < pos.1.y + CGFloat(size) {
                flagSelector?(pos.0)
                pressingPoint = nil
            }
        }
    }
    
    private func drawFirstAndLastPoint(endPoint: CGPoint, startPoint: CGPoint) {
        drawPoint(color: UIColor.lightGray, x: endPoint.x, y: endPoint.y)
        drawPoint(color: UIColor.lightGray, x: startPoint.x, y: startPoint.y)
    }
    
    private func drawPoint(color: UIColor, x: CGFloat, y: CGFloat, lineWidth: CGFloat = 3.0) {
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: x, y: y),
                                      radius: CGFloat(6), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        let cshapeLayer = CAShapeLayer()
        cshapeLayer.path = circlePath.cgPath
        cshapeLayer.fillColor = color.cgColor
        cshapeLayer.strokeColor = color.cgColor
        cshapeLayer.lineWidth = lineWidth
        layer.addSublayer(cshapeLayer)
        
    }
    
    private func drawCastle(x: CGFloat, y: CGFloat, value: String? = nil, isDone: Bool = false) {
        
        lazy var fireworkImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "firework")
            imageView.contentMode = .scaleAspectFill
            return imageView
        }()
        
        lazy var castelLabel: UILabel = {
            let label = UILabel()
            label.text = value
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            return label
        }()
        
        let shapeCastleLayer = CAShapeLayer()
        shapeCastleLayer.path = path.cgPath
        shapeCastleLayer.fillColor = UIColor.clear.cgColor
        pathViewCastle.layer.addSublayer(shapeCastleLayer)
        
        let imageCastle = UIImage(named: "castle")!
        imageViewCastle = UIImageView(image: imageCastle)
        imageViewCastle.contentMode = .scaleAspectFill
        
        imageViewCastle.frame = CGRect(x: x - 40, y: y - 80, width: imageCastle.size.width, height: imageCastle.size.height)
        
        pathViewCastle.addSubview(imageViewCastle)
        
        castelLabel.frame = CGRect(x: x - 50, y: y - 140, width: 100, height: 100)
        fireworkImageView.frame = CGRect(x: x - 40, y: y - 140, width: imageCastle.size.width, height: imageCastle.size.height)
        
        if isDone {
            addSubview(fireworkImageView)
        }
        
        addSubview(castelLabel)
    }
    
    private func drawFlag(name: String, x: CGFloat, y: CGFloat, value: String? = nil) {
        
        lazy var label: UILabel = {
            let label = UILabel()
            label.text = value
            label.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
            return label
        }()
        
        let image = UIImage(named: name)!
        imageViewFlag = UIImageView(image: image)
        imageViewFlag.contentMode = .scaleAspectFill
        
        imageViewFlag.frame = CGRect(x: x, y: y, width: width * 0.07, height: width * 0.07)
        pathViewFlag.addSubview(imageViewFlag)
        
        if let countChar = value?.count {
            if countChar >= 3 {
                label.frame = CGRect(x: x - 30, y: y - 30, width: 100, height: 100)
            } else if countChar == 2 {
                label.frame = CGRect(x: x - 20, y: y - 30, width: 100, height: 100)
            } else {
                label.frame = CGRect(x: x - 15, y: y - 30, width: 100, height: 100)
            }
        }
        
        addSubview(label)
    }
    
    private func drawHorse(color: UIColor, x: CGFloat, y: CGFloat, isFlippedPosition: Bool, value: String? = nil, isDone: Bool? = false, positionHorse: CGRect, valuePosition: CGRect) {
        
        lazy var valueView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.magentoColor
            view.layer.cornerRadius = 5
            return view
        }()
        
        lazy var valueLabel: UILabel = {
            let label = UILabel()
            label.text = value
            label.textAlignment = .center
            label.textColor = UIColor.white
            label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            return label
        }()
        
        var name: String = ""
        let circleHorse = UIBezierPath(arcCenter: CGPoint(x: x, y: y), radius: CGFloat(4), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let cshapeHorseLayer = CAShapeLayer()
        cshapeHorseLayer.path = circleHorse.cgPath
        cshapeHorseLayer.fillColor = color.cgColor
        cshapeHorseLayer.strokeColor = UIColor.magentoColor.cgColor
        cshapeHorseLayer.lineWidth = 2.0
        
        if isFlippedPosition {
            name = "right_horse"
        } else {
            name = "left_horse"
        }
        
        let image = UIImage(named: name)!
        imageViewHorse = UIImageView(image: image)
        imageViewHorse.contentMode = .scaleAspectFill
        imageViewHorse.frame = positionHorse
        imageViewHorse.isUserInteractionEnabled = false
        
        valueLabel.frame = valuePosition
        valueView.frame = valuePosition
        
        if isDone == false {
            addSubview(valueView)
            addSubview(valueLabel)
            pathViewHourse.addSubview(imageViewHorse)
            layer.addSublayer(cshapeHorseLayer)
        }
    }
    
    private func drawLine(color: UIColor, x: CGFloat, y: CGFloat, lineWidth: CGFloat = 0.001) {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: x, y: y),
                                      radius: CGFloat(2), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        let cshapeLayer = CAShapeLayer()
        cshapeLayer.path = circlePath.cgPath
        cshapeLayer.fillColor = color.cgColor
        cshapeLayer.strokeColor = color.cgColor
        cshapeLayer.lineWidth = lineWidth
        layer.addSublayer(cshapeLayer)
    }
    
    private func getValuePosition(ratio: CGFloat, x: CGFloat, y: CGFloat) -> CGRect {
        switch ratio {
        case 0.032...0.84:
            return CGRect(x: x - 20, y: y + 10, width: width * 0.08, height: height * 0.03)
        case 0.84...0.86:
            return CGRect(x: x + 10, y: y - 15, width: width * 0.08, height: height * 0.03)
        default:
            return CGRect(x: x - 15, y: y + 10, width: width * 0.08, height: height * 0.03)
        }
    }
    
    private func getHoursePosition(ratio: CGFloat, x: CGFloat, y: CGFloat) -> CGRect {
        switch ratio {
        case 0.84...0.86:
            return CGRect(x: x - 40, y: y - 40, width: width * 0.08, height: width * 0.08)
        default:
            return CGRect(x: x - 20, y: y - 45, width: width * 0.08, height: width * 0.08)
        }
    }
    
    private func isFlippedPosition(ratio: Float) -> Bool {
        switch ratio {
        case 0.01...0.10:
            return false
        case 0.10...0.28:
            return true
        case 0.28...0.47:
            return false
        case 0.47...0.66:
            return true
        case 0.66...0.84:
            return false
        case 0.84...1.0:
            return true
        default:
            return false
        }
    }
    
    private func getFlagPoint(point: CGPoint, ratio: CGFloat) -> CGPoint {
        let size = width * 0.07
        switch ratio {
        case 0.01...0.08:
            return CGPoint(x: point.x - (size * 0.2), y: point.y - (size * 1.3))
        case 0.09...0.09:
            return CGPoint(x: point.x - (size * 0.6), y: point.y + (size * 0.1))
        case 0.1...0.11:
            return CGPoint(x: point.x - (size * 1.0), y: point.y - (size * 1.0))
        case 0.12...0.25:
            return CGPoint(x: point.x - (size * 0.6), y: point.y - (size * 1.3))
        case 0.26...0.27:
            return CGPoint(x: point.x - (size * 0.3), y: point.y + (size * 0.4))
        case 0.28...0.29:
            return CGPoint(x: point.x + (size * 0.2), y: point.y - (size * 0.7))
        case 0.30...0.44:
            return CGPoint(x: point.x - (size * 0.2), y: point.y - (size * 1.3))
        case 0.45...0.47:
            return CGPoint(x: point.x - (size * 0.7), y: point.y + (size * 0.1))
        case 0.48...0.49:
            return CGPoint(x: point.x - (size * 0.65), y: point.y - (size * 1.1))
        case 0.50...0.54:
            return CGPoint(x: point.x - (size * 0.4), y: point.y - (size * 1.3))
        case 0.55...0.65:
            return CGPoint(x: point.x - (size * 0.4), y: point.y + (size * 0.4))
        case 0.66...0.67:
            return CGPoint(x: point.x + (size * 0.2), y: point.y - (size * 0.95))
        case 0.68...0.8:
            return CGPoint(x: point.x - (size * 0.3), y: point.y - (size * 1.3))
        case 0.81...0.83:
            return CGPoint(x: point.x - (size * 0.8), y: point.y + (size * 0.03))
        case 0.84...0.86:
            return CGPoint(x: point.x - (size * 1.0), y: point.y - (size * 1.0))
        case 0.87...0.97:
            return CGPoint(x: point.x - (size * 0.3), y: point.y - (size * 1.3))
        case 0.98...1.0:
            return CGPoint(x: point.x - (size * 0.1), y: point.y + (size * 0.3))
        default:
            return point
        }
    }
    
}
