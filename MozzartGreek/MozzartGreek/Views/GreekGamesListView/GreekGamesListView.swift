//
//  GreekGamesListView.swift
//  MozzartGreek
//
//  Created by Djordje Andric on 18.07.24.
//

import SwiftUI

struct GreekGamesListView: View {
    @StateObject private var viewModel = GreekGamesViewModel()
    
    var body: some View {
//        NavigationView {
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
//            }
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        
                        Text("Greek game")
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

struct GreekGamesListView_Previews: PreviewProvider {
    static var previews: some View {
        GreekGamesListView()
    }
}
