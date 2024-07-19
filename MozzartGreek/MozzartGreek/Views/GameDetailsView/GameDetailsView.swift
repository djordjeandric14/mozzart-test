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
    
    private var items: [RowItem] = (1...80).map { RowItem(number: $0) }
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 10)
    
    public var body: some View {
        VStack {
            Text("Selektovano kuglica: \(viewModel.selectedNumbersCount)")
            Text("Izvlačenje: \(viewModel.game.prettyString)")
            Text("Broj kola: \(viewModel.game.drawId)")
            Text("Preostalo za uplatu: \(TimeFormatter.prettyShown(remaining: viewModel.game.timeLeft))")
                .foregroundColor(viewModel.game.timeLeft < 60 ? .red : .black)
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(items) { item in
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
            NavigationLink("Uživo izvlačenje") {
                                LiveGreekWebView()
                            }
            Spacer()
        }
    }
}
//
//struct GameDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameDetailsView()
//    }
//}

