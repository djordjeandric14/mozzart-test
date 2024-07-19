//
//  GameDetailsView.swift
//  MozzartGreek
//
//  Created by Djordje Andric on 18.07.24.
//

import SwiftUI

public struct GameDetailsView: View {
    @StateObject var viewModel: GameDetailsViewModel
    
    public init(game: GreekGames) {
        _viewModel = StateObject(wrappedValue: GameDetailsViewModel(game: game))
    }
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 10)
    
    public var body: some View {
        VStack {
            Text("Selektovano kuglica: \(viewModel.selectedNumbersCount)")
            Text("Izvlačenje: \(viewModel.game.prettyString)")
            Text("Broj kola: \(viewModel.game.prettyDrawId)")
            Text("Preostalo za uplatu: \(TimeFormatter.prettyShown(remaining: viewModel.game.timeLeft))")
                .foregroundColor(viewModel.game.timeLeft < 60 ? .red : .green)
            
            headerStack
            lazyGrid
            
            NavigationLink("Uživo izvlačenje") {
                LiveGreekWebView()
            }
            Spacer()
        }
    }
    
    var headerStack: some View {
        HStack {
            Button(action: {
                viewModel.randomizeNumbers()
            }) {
                Text("Slučajni odabir")
                    .foregroundColor(.white)
                    .padding()
                    .frame(height: 40)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()

            Spacer()
            
            Menu("Brojeva: \(viewModel.maxNumbers) ⬇") {
                ForEach(2...5, id: \.self) { number in
                    Button("\(number)") {
                        viewModel.maxNumbers = number
                        viewModel.selectedNumbers.removeAll()
                    }
                }
            }
        }
        .padding()
    }
    
    var lazyGrid: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(viewModel.items) { item in
                HStack {
                    Text("\(item.number)")
                        .padding(4)
                }
                .onTapGesture {
                    viewModel.numberSelected(number: item.number)
                }
                .frame(maxWidth: .infinity)
                .clipShape(Circle())
                .overlay {
                    if viewModel.selectedNumbers.contains(item.number) {
                        Circle().stroke(item.color, lineWidth: 2)
                    }
                }
            }
        }
    }
}
