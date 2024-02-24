//
//  Snake.swift
//  SnakeApp
//
//  Created by  Alexey on 16.02.2024.
//

import Foundation

public struct Snake: Decodable {
    
    public let planType: String?
    public let planName: String?
    public let endDate: String?
    public let maxPosition: Int?
    public let currentPosition: Int?
    public let positionList: [PositionList]?
}

public struct PositionList: Decodable {
    public let position: Int
    public let prize: Int
    public let type: PositionType
}

public enum PositionType: String, Decodable {
    case MONEY = "MONEY"
}

extension Snake {
    static func getData() -> Snake {
        return Snake(
            planType: "ONETIME",
            planName: "ntest razovyi",
            endDate: "2024-03-31 23:59",
            maxPosition: 50,
            currentPosition: 48,
            positionList: [
                PositionList(position: 3, prize: 30, type: .MONEY),
                PositionList(position: 10, prize: 5000, type: .MONEY),
                PositionList(position: 15, prize: 1000, type: .MONEY),
                PositionList(position: 50, prize: 10000, type: .MONEY)
            ]
        )
    }
}

