//
//  MozzartGreekApp.swift
//  MozzartGreek
//
//  Created by Djordje Andric on 18.07.24.
//

import SwiftUI

@main
struct MozzartGreekApp: App {
    @StateObject private var bannerManager = BannerManager()
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(bannerManager)
                .overlay(BannerView().environmentObject(bannerManager))
        }
    }
}
