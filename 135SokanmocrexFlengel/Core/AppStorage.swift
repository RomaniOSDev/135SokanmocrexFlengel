//
//  AppStorage.swift
//  135SokanmocrexFlengel
//

import Combine
import Foundation

@MainActor
final class ProgressStore: ObservableObject {
    private let defaults: UserDefaults

    private enum Key {
        static let prefix = "trivia.progress."
        static let onboarding = prefix + "hasSeenOnboarding"
        static let playSeconds = prefix + "totalPlaySeconds"
        static let sessions = prefix + "totalSessionsCompleted"
        static let correct = prefix + "totalCorrectAnswers"
        static let maxStarsSession = prefix + "maxStarsSingleSession"
        static let challengeStars = prefix + "challengeBestStars."
    }

    @Published private(set) var hasSeenOnboarding: Bool
    @Published private(set) var revision: Int = 0

    private func bump() {
        revision &+= 1
        objectWillChange.send()
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        hasSeenOnboarding = defaults.bool(forKey: Key.onboarding)
    }

    // MARK: - Onboarding

    func completeOnboarding() {
        defaults.set(true, forKey: Key.onboarding)
        hasSeenOnboarding = true
        bump()
    }

    // MARK: - Stars per level

    func stars(for activity: ActivityKind, level: Int) -> Int {
        let key = Self.starsKey(activity: activity, level: level)
        return defaults.integer(forKey: key)
    }

    func updateStarsIfBetter(activity: ActivityKind, level: Int, stars newValue: Int) {
        let key = Self.starsKey(activity: activity, level: level)
        let current = defaults.integer(forKey: key)
        if newValue > current {
            defaults.set(newValue, forKey: key)
            bump()
        }
    }

    func isLevelUnlocked(activity: ActivityKind, level: Int) -> Bool {
        guard level >= 1, level <= ActivityKind.levelCount else { return false }
        if level == 1 { return true }
        return stars(for: activity, level: level - 1) >= 1
    }

    // MARK: - Challenge tab best stars

    func challengeBestStars(difficulty: Difficulty) -> Int {
        defaults.integer(forKey: Key.challengeStars + difficulty.rawValue)
    }

    func updateChallengeStarsIfBetter(difficulty: Difficulty, stars newValue: Int) {
        let key = Key.challengeStars + difficulty.rawValue
        let current = defaults.integer(forKey: key)
        if newValue > current {
            defaults.set(newValue, forKey: key)
            bump()
        }
    }

    // MARK: - Session recording

    func recordSession(
        activity: ActivityKind,
        level: Int,
        starsEarned: Int,
        correctAnswers: Int,
        durationSeconds: TimeInterval
    ) {
        updateStarsIfBetter(activity: activity, level: level, stars: starsEarned)
        let prevMax = defaults.integer(forKey: Key.maxStarsSession)
        if starsEarned > prevMax {
            defaults.set(starsEarned, forKey: Key.maxStarsSession)
        }
        defaults.set(totalSessionsCompleted + 1, forKey: Key.sessions)
        defaults.set(totalCorrectAnswers + correctAnswers, forKey: Key.correct)
        let extra = Int(durationSeconds.rounded())
        defaults.set(totalPlaySeconds + max(0, extra), forKey: Key.playSeconds)
        bump()
    }

    func recordChallengeSession(starsEarned: Int, correctAnswers: Int, durationSeconds: TimeInterval, difficulty: Difficulty) {
        updateChallengeStarsIfBetter(difficulty: difficulty, stars: starsEarned)
        let prevMax = defaults.integer(forKey: Key.maxStarsSession)
        if starsEarned > prevMax {
            defaults.set(starsEarned, forKey: Key.maxStarsSession)
        }
        defaults.set(totalSessionsCompleted + 1, forKey: Key.sessions)
        defaults.set(totalCorrectAnswers + correctAnswers, forKey: Key.correct)
        let extra = Int(durationSeconds.rounded())
        defaults.set(totalPlaySeconds + max(0, extra), forKey: Key.playSeconds)
        bump()
    }

    // MARK: - Aggregates (for UI & achievements)

    var totalPlaySeconds: Int {
        defaults.integer(forKey: Key.playSeconds)
    }

    var totalSessionsCompleted: Int {
        defaults.integer(forKey: Key.sessions)
    }

    var totalCorrectAnswers: Int {
        defaults.integer(forKey: Key.correct)
    }

    var maxStarsInSingleSession: Int {
        defaults.integer(forKey: Key.maxStarsSession)
    }

    var totalLevelsCompleted: Int {
        ActivityKind.allCases.reduce(0) { partial, activity in
            partial + (1...ActivityKind.levelCount).filter { stars(for: activity, level: $0) >= 1 }.count
        }
    }

    var totalThreeStarLevels: Int {
        ActivityKind.allCases.reduce(0) { partial, activity in
            partial + (1...ActivityKind.levelCount).filter { stars(for: activity, level: $0) >= 3 }.count
        }
    }

    var landmarkLevelsCompleted: Int {
        completedCount(for: .landmark)
    }

    var culturalLevelsCompleted: Int {
        completedCount(for: .cultural)
    }

    var historicalLevelsCompleted: Int {
        completedCount(for: .historical)
    }

    private func completedCount(for activity: ActivityKind) -> Int {
        (1...ActivityKind.levelCount).filter { stars(for: activity, level: $0) >= 1 }.count
    }

    var totalStarsCollected: Int {
        ActivityKind.allCases.reduce(0) { acc, activity in
            acc + (1...ActivityKind.levelCount).reduce(0) { $0 + stars(for: activity, level: $1) }
        }
    }

    // MARK: - Reset

    func resetAllProgress() {
        let dict = defaults.dictionaryRepresentation()
        for key in dict.keys where key.hasPrefix(Key.prefix) {
            defaults.removeObject(forKey: key)
        }
        defaults.removeObject(forKey: Key.onboarding)
        hasSeenOnboarding = false
        bump()
        NotificationCenter.default.post(name: .progressStoreDidReset, object: nil)
    }

    private static func starsKey(activity: ActivityKind, level: Int) -> String {
        Key.prefix + "stars.\(activity.rawValue).\(level)"
    }
}
