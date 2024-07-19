//
//  GameDetailsVIewModel.swift
//  MozzartGreek
//
//  Created by Djordje Andric on 18.07.24.
//

import Foundation

class GameDetailsViewModel: ObservableObject {
    private var countdownTimer: Timer?
    @Published var selectedNumbers: [Int] = []
    @Published var date = Date()
    
    let game: GreekGames
    
    init(game: GreekGames) {
        self.game = game
        startCountdown()
    }
    
    private func startCountdown() {
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.date = Date()
        }
    }
    
    var selectedNumbersCount: Int {
        selectedNumbers.count
    }
    
    func numberSelected(number: Int) {
        if selectedNumbers.contains(number) {
            if let index = selectedNumbers.firstIndex(where: { $0 == number }) {
                selectedNumbers.remove(at: index)
            }
        } else {
            
            if selectedNumbers.count > 4 {
                return
            }
            
            selectedNumbers.append(number)
        }
    }
    
}
struct RowItem: Identifiable {
    let id = UUID()
    let number: Int
    let color = Colors.random
}
