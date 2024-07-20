//
//  BannerView.swift
//  MozzartGreek
//
//  Created by Djordje Andric on 20.07.24.
//

import SwiftUI

struct Banner: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var message: String
    var type: BannerType
}

enum BannerType {
    case success
    case warning
    case error
}

class BannerManager: ObservableObject {
    @Published var banner: Banner?
    
    func showBanner(title: String, message: String, type: BannerType) {
        banner = Banner(title: title, message: message, type: type)
    }
}

struct BannerView: View {
    @EnvironmentObject var bannerManager: BannerManager
    @State private var isPresented = false
    
    var body: some View {
        VStack {
            if let banner = bannerManager.banner, isPresented {
                HStack {
                    Text(banner.title)
                        .font(.headline)
                        .padding()
                    Text(banner.message)
                        .padding()
                    Spacer()
                }
                .background(color(for: banner.type))
                .cornerRadius(8)
                .padding()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            isPresented = false
                            bannerManager.banner = nil
                        }
                    }
                }
                
                Spacer()
            }
        }
        .onChange(of: bannerManager.banner) { _ in
            withAnimation {
                isPresented = true
            }
        }
    }
    
    private func color(for type: BannerType) -> Color {
        switch type {
            case .success:
                return Color.green
            case .warning:
                return Color.yellow
            case .error:
                return Color.red
        }
    }
}
