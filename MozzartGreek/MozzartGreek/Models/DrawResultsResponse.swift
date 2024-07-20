//
//  DrawResultsResponse.swift
//  MozzartGreek
//
//  Created by Djordje Andric on 19.07.24.
//

import Foundation

struct History: Codable {
    let content: [DrawResults]
}

public struct DrawResults: Codable, Identifiable {
    public var id: UUID {
        UUID()
    }
    
    var prettyDrawId: String {
        String(drawId)
    }
    
    var prettyDateString: String {
        TimeFormatter.prettyString(date: date, format: "dd.MM.yyyy HH:mm")
    }
    
    var date: Date {
        Date(timeIntervalSince1970: drawTime / 1000)
    }
    
    let drawId: Int
    let drawTime: Double
    let winningNumbers: WinningNumbers
    
    
}

struct WinningNumbers: Codable {
    let list, bonus: [Int]
    
    var sortedList: [Int] {
        list.sorted()
    }
}
