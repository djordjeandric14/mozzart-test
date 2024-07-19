//
//  GreekGamesListView.swift
//  MozzartGreek
//
//  Created by Djordje Andric on 18.07.24.
//

import SwiftUI

struct GreekGamesListView: View {
    @StateObject var viewModel = GreekGamesViewModel()
    
    var body: some View {
        NavigationView {
            NavigationStack {
                List {
                    ForEach(viewModel.games) { game in
                        NavigationLink {
                            GameDetailsView(game: game)
                        } label: {
                            HStack {
                                Text("Izvlačenje: \(game.prettyString)")
                                    .font(.footnote)
                                Spacer()
                                Text("Preostalo za uplatu: \(TimeFormatter.prettyShown(remaining: game.timeLeft))")
                                    .foregroundColor(game.timeLeft < 60 ? .red : .black)
                                    .font(.caption)
                            }
                        }
                        
                    }
                }
                .navigationTitle("Greek")
            }
            
        }
        
    }
}

struct GreekGamesListView_Previews: PreviewProvider {
    static var previews: some View {
        GreekGamesListView()
    }
}
