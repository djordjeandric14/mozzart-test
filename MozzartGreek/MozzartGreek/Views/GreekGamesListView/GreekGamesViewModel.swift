//
//  GreekGamesViewModel.swift
//  MozzartGreek
//
//  Created by Djordje Andric on 18.07.24.
//

import Foundation
import SwiftUI

class GreekGamesViewModel: ObservableObject {
    private let apiService = APIService.shared
    private var countdownTimer: Timer?
    var bannerManager: BannerManager?
    
    @Published var games: [GreekGames] = []
    @Published var date = Date()
    
    init() {
        startCountdown()
        getAllGames()
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
    
    private func startCountdown() {
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.date = Date()
            
            self.checkExpiredGames()
        }
    }
    
    private func checkExpiredGames() {
        let hasExpiredGames = games.first(where: { $0.timeLeft <= 0 }) != nil
        
        if hasExpiredGames {
            showBanner()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                withAnimation(.easeInOut(duration: 1)) {
                    self.games.removeAll(where: { $0.timeLeft <= 0 })
                }
                
            })
            
        }
    }
    
    private func showBanner() {
        guard let manager = bannerManager else { return }
        
        manager.showBanner(title: "Obaveštenje", message: "Jedna igra je istekla, biće uklonjena iz liste.", type: .error)
    }
}
