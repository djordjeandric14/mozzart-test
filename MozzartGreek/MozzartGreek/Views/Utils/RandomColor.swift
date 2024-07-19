//
//  RandomColor.swift
//  MozzartGreek
//
//  Created by Djordje Andric on 18.07.24.
//

import SwiftUI

class Colors {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
