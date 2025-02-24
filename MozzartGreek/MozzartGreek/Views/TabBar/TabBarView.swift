//
//  TabBarView.swift
//  MozzartGreek
//
//  Created by Djordje Andric on 19.07.24.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            GreekGamesListView()
                .tabItem {
                    Image(systemName: "shuffle")
                    Text("Izvlačenje")
                }
                .tag(0)
            LiveGreekWebView()
                .tabItem {
                    Image(systemName: "bolt.circle.fill")
                    Text("Uživo izvlačenje")
                }
                .tag(1)
            ResultsView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Rezultati")
                }
                .tag(2)
        }
    }
}


