//
//  TimeFormatter.swift
//  MozzartGreek
//
//  Created by Djordje Andric on 18.07.24.
//

import Foundation

class TimeFormatter {
    static func prettyShown(remaining: Double) -> String {
        if remaining <= 0 {
            return "00:00"
        } else {
            let hours = Int(remaining) / 3600
            let minutes = Int(remaining) / 60 % 60
            let seconds = Int(remaining) % 60
            
            if hours >= 1 {
                return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            } else {
                return String(format: "%02d:%02d", minutes, seconds)
            }
        }
    }
    
    static func endpointDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date)
    }
    
    static func prettyString(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = .current
        formatter.locale = .current
        
        return formatter.string(from: date)
    }
}
