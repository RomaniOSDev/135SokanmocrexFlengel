//
//  ExplorePath.swift
//  135SokanmocrexFlengel
//

import Foundation

enum ExplorePath: Hashable {
    case levels(ActivityKind)
    case playLandmark(level: Int, difficulty: Difficulty)
    case playCultural(level: Int, difficulty: Difficulty)
    case playHistorical(level: Int, difficulty: Difficulty)
    case outcome(SessionOutcome)
}
