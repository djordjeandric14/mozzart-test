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
        TimeFormatter.prettyString(date: date, format: "HH:mm")
    }
    
    var timeLeft: Double {
        date.timeIntervalSince(.now) - 15
    }
    
    var date: Date {
        Date(timeIntervalSince1970: drawTime / 1000)
    }
    
    var prettyDrawId: String {
        String(drawId)
    }
    
    let gameId: Int
    let drawId: Int
    let drawTime: Double
    let status: String
    let drawBreak: Int
    let visualDraw: Int
}
