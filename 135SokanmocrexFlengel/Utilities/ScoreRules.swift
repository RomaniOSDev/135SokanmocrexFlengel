//
//  ScoreRules.swift
//  135SokanmocrexFlengel
//

import Foundation

enum ScoreRules {
    static func starRating(correct: Int, total: Int) -> Int {
        guard total > 0 else { return 0 }
        let ratio = Double(correct) / Double(total)
        if ratio >= 0.9 { return 3 }
        if ratio >= 0.65 { return 2 }
        if ratio >= 0.35 { return 1 }
        return 0
    }

    static func completionPercent(correct: Int, total: Int) -> Int {
        guard total > 0 else { return 0 }
        return Int((Double(correct) / Double(total) * 100).rounded())
    }
}
