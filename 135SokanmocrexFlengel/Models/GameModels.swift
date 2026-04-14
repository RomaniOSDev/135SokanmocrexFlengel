//
//  GameModels.swift
//  135SokanmocrexFlengel
//

import Foundation

enum ActivityKind: String, CaseIterable, Identifiable, Hashable, Codable {
    case landmark
    case cultural
    case historical

    var id: String { rawValue }

    var displayTitle: String {
        switch self {
        case .landmark: return "Landmark Trivia"
        case .cultural: return "Cultural Conundrums"
        case .historical: return "Historical Hurdles"
        }
    }

    var subtitle: String {
        switch self {
        case .landmark: return "Questions about iconic places around the world."
        case .cultural: return "Festivals, traditions, and everyday life worldwide."
        case .historical: return "Timed questions on major events and eras."
        }
    }

    static let levelCount = 12
    static let questionsPerLevel = 5
}

enum Difficulty: String, CaseIterable, Identifiable, Hashable, Codable {
    case easy
    case normal
    case hard

    var id: String { rawValue }

    var title: String {
        rawValue.capitalized
    }

    var lives: Int {
        switch self {
        case .easy: return 3
        case .normal: return 2
        case .hard: return 1
        }
    }

    /// Seconds per question for timed modes (Cultural hard / Historical all).
    var timedQuestionSeconds: Int {
        switch self {
        case .easy: return 22
        case .normal: return 16
        case .hard: return 10
        }
    }

    var showsHints: Bool {
        self == .easy
    }
}

struct TriviaItem: Identifiable, Hashable {
    let id: String
    let prompt: String
    let options: [String]
    let correctIndex: Int
    let explanation: String
    let hint: String?
}

struct SessionOutcome: Hashable {
    let activity: ActivityKind
    let levelIndex: Int
    let difficulty: Difficulty
    let correctCount: Int
    let totalQuestions: Int
    let elapsedSeconds: TimeInterval
    let earnedStars: Int
    let isPerfectRun: Bool
    let newlyUnlockedAchievements: [Achievement]
    let newlyUnlockedRewards: [PlayerReward]
    let isMixedChallenge: Bool
}

struct Achievement: Identifiable, Hashable {
    let id: String
    let title: String
    let detail: String
}

enum AchievementCatalog {
    static func allUnlocked(using store: ProgressStore) -> [Achievement] {
        var list: [Achievement] = []
        if store.totalLevelsCompleted >= 1 {
            list.append(Achievement(id: "first_victory", title: "First Victory", detail: "Complete any level once."))
        }
        if store.maxStarsInSingleSession >= 3 {
            list.append(Achievement(id: "stellar_run", title: "Stellar Run", detail: "Earn three stars in a single session."))
        }
        if store.totalThreeStarLevels >= 3 {
            list.append(Achievement(id: "triple_glow", title: "Triple Glow", detail: "Collect three stars on three different levels."))
        }
        if store.landmarkLevelsCompleted >= ActivityKind.levelCount {
            list.append(Achievement(id: "pathfinder", title: "Pathfinder", detail: "Finish every Landmark Trivia level."))
        }
        if store.culturalLevelsCompleted >= ActivityKind.levelCount {
            list.append(Achievement(id: "world_wanderer", title: "World Wanderer", detail: "Finish every Cultural Conundrums level."))
        }
        if store.historicalLevelsCompleted >= ActivityKind.levelCount {
            list.append(Achievement(id: "timeline_trekker", title: "Timeline Trekker", detail: "Finish every Historical Hurdles level."))
        }
        if store.totalCorrectAnswers >= 100 {
            list.append(Achievement(id: "sharp_mind", title: "Sharp Mind", detail: "Answer 100 questions correctly in total."))
        }
        if store.totalPlaySeconds >= 600 {
            list.append(Achievement(id: "dedicated_player", title: "Dedicated Player", detail: "Spend 10 minutes playing in total."))
        }
        if store.totalSessionsCompleted >= 15 {
            list.append(Achievement(id: "regular_contender", title: "Regular Contender", detail: "Complete 15 sessions."))
        }
        return list
    }

    static func idsUnlocked(using store: ProgressStore) -> Set<String> {
        Set(allUnlocked(using: store).map(\.id))
    }
}
