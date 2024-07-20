//
//  GreekGamesListView.swift
//  MozzartGreek
//
//  Created by Djordje Andric on 18.07.24.
//

import SwiftUI

struct GreekGamesListView: View {
    @StateObject private var viewModel = GreekGamesViewModel()
    @EnvironmentObject var bannerManager: BannerManager
    
    var body: some View {
        NavigationStack {
            List(viewModel.games) { game in
                NavigationLink(destination: GameDetailsView(game: game)) {
                    HStack {
                        Text("Izvlačenje: \(game.prettyString)")
                            .font(.footnote)
                        Spacer()
                        Text("Preostalo za uplatu: \(TimeFormatter.prettyShown(remaining: game.timeLeft))")
                            .foregroundColor(game.timeLeft < 60 ? .red : .primary)
                            .font(.caption)
                    }
                }
            }
            .onAppear {
                viewModel.bannerManager = bannerManager
            }
            .refreshable {
                viewModel.getAllGames()
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        
                        Text("Grčki kino")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Image("mozzart")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 35)
                    }
                }
            }
        }
    }
}
