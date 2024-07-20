//
//  ResultsView.swift
//  MozzartGreek
//
//  Created by Djordje Andric on 19.07.24.
//

import SwiftUI

struct ResultsView: View {
    @StateObject private var viewModel = ResultsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.results) { result in
                VStack(alignment: .leading) {
                    Text("Kolo: \(result.prettyDrawId)")
                        .font(.headline)
                    Text("Datum: \(result.prettyDateString)")
                        .font(.subheadline)
                    GridView(items: result.winningNumbers.sortedList)
                }
                .padding(.vertical, 8)
            }
            .refreshable {
                viewModel.getAllResults()
            }
            .navigationTitle("Rezultati izvlačenja")
        }
    }
}
