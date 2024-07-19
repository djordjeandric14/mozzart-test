//
//  ResultsViewModel.swift
//  MozzartGreek
//
//  Created by Djordje Andric on 19.07.24.
//

import SwiftUI

class ResultsViewModel: ObservableObject {
    private let apiService = APIService.shared
    
    @Published var results: [DrawResults] = []
    
    init() {
        getAllResults()
    }
    
    func getAllResults() {
        Task {
            do {
                let resultsResponse: History = try await apiService.performRequest(endpoint: Endpoint.results())
                
                DispatchQueue.main.async { [weak self] in
                    self?.results = resultsResponse.content
                }
                
            } catch {
                
            }
        }
    }
    
}
