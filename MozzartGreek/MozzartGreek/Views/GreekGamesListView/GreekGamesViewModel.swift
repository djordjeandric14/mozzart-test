//
//  GreekGamesViewModel.swift
//  MozzartGreek
//
//  Created by Djordje Andric on 18.07.24.
//

import Foundation

class GreekGamesViewModel: ObservableObject {
    private let apiService = APIService.shared
    private var countdownTimer: Timer?
    
    @Published var games: [GreekGames] = []
    @Published var date = Date()
    
    init() {
        startCountdown()
        getAllGames()
    }

    private func startCountdown() {
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.date = Date()
        }
    }
    
    func getAllGames() {
        Task {
            do {
                let gamesResponse: [GreekGames] = try await apiService.performRequest(endpoint: Endpoint.greekGames())
                
                DispatchQueue.main.async { [weak self] in
                    self?.games = gamesResponse
                }
                
            } catch {
                
            }
        }
    }
    
}
