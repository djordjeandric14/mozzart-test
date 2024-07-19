//
//  Color.swift
//  MozzartGreek
//
//  Created by Djordje Andric on 19.07.24.
//
import SwiftUI


extension Color {
    static let customBackground = Color("customBackground")
    static let customPrimary = Color("customPrimary")
    static let customSecondary = Color("customSecondary")
    static let customAccent = Color("customAccent")
    
    static let background = Color(hex: "#0e1c42")
    static let fontBasic = Color(hex: "#929494")
    static let fontActive = Color(hex: "#ececec")
    static let highlight = Color(hex: "#016db6")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}
