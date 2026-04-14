//
//  ChallengePath.swift
//  135SokanmocrexFlengel
//

import Foundation

enum ChallengePath: Hashable {
    case play(Difficulty)
    case outcome(SessionOutcome)
}
