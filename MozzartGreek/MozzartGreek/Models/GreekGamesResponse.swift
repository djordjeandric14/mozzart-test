//
//  GreekGamesResponse.swift
//  MozzartGreek
//
//  Created by Djordje Andric on 18.07.24.
//

import Foundation

public struct GreekGames: Codable, Identifiable {
    
    public var id: UUID {
        UUID()
    }
    
    var prettyString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = .current
        formatter.locale = .current

        return formatter.string(from: date)
    }
    
    var timeLeft: Double {
        date.timeIntervalSince(.now) - 15        
    }
    
    
    var date: Date {
        Date(timeIntervalSince1970: drawTime / 1000)
    }
    
    let gameId: Int
    let drawId: Int
    let drawTime: Double
    let status: String
    let drawBreak: Int
    let visualDraw: Int
//    let pricePoints: PricePoints
//    let prizeCategories: [PrizeCategory]
//    let wagerStatistics: WagerStatistics
}
