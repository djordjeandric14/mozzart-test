//
//  GridView.swift
//  MozzartGreek
//
//  Created by Djordje Andric on 19.07.24.
//

import SwiftUI

struct GridView: View {
    let items: [Int]
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 5)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(items.indices, id: \.self) { index in
                    Text("\(items[index])")
                        .frame(width: 50, height: 50)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Colors.random, lineWidth: 2)
                        )
                        .padding(5)
                }
            }
            .padding()
        }
        .background(Color.gray.opacity(0.1))
    }
}
