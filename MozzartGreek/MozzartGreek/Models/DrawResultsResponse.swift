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
    
    let drawId: Int
    let drawTime: Int
    let winningNumbers: WinningNumbers
}

struct WinningNumbers: Codable {
    let list, bonus: [Int]

//    let sidebets: Sidebets
}
