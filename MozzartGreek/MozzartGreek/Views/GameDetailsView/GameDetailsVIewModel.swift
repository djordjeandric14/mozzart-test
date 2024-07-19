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
    
    @Published var maxNumbers = 5
    lazy var items: [RowItem] = {
        (1...maxSlotNumber).map { RowItem(number: $0) }
    }()
    var maxSlotNumber = 80
    
    let game: GreekGames
    
    init(game: GreekGames) {
        self.game = game
        startCountdown()
    }
    
    deinit {
        debugPrint("Timer allowed viewModel DEINIT")
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
            if selectedNumbers.count >= maxNumbers {
                return
            }
            
            selectedNumbers.append(number)
        }
    }
    
    func randomizeNumbers() {
        selectedNumbers = getRandomNumbers(x: maxNumbers, upTo: maxSlotNumber)
    }
    
    private func getRandomNumbers(x: Int, upTo y: Int) -> [Int] {
        var uniqueNumbers = Set<Int>()
        
        while uniqueNumbers.count < x {
            let randomNumber = Int.random(in: 1...y)
            uniqueNumbers.insert(randomNumber)
        }
        
        return Array(uniqueNumbers)
    }
    
}

struct RowItem: Identifiable {
    let id = UUID()
    let number: Int
    let color = Colors.random
}
