//
//  ActivityPlayCoordinators.swift
//  135SokanmocrexFlengel
//

import Combine
import SwiftUI

struct LandmarkPlayCoordinator: View {
    @EnvironmentObject private var store: ProgressStore
    @Binding var path: NavigationPath
    let level: Int
    let difficulty: Difficulty

    @StateObject private var viewModel: LandmarkTriviaViewModel
    @State private var didFinish = false

    init(path: Binding<NavigationPath>, level: Int, difficulty: Difficulty) {
        _path = path
        self.level = level
        self.difficulty = difficulty
        _viewModel = StateObject(wrappedValue: LandmarkTriviaViewModel(level: level, difficulty: difficulty))
    }

    var body: some View {
        LandmarkTriviaView(viewModel: viewModel)
            .navigationTitle("Level \(level)")
            .navigationBarTitleDisplayMode(.inline)
            .onReceive(viewModel.isFinishedPublisher) { finished in
                guard finished, !didFinish else { return }
                didFinish = true
                completeSessionLandmark()
            }
    }

    private func completeSessionLandmark() {
        let stars = ScoreRules.starRating(correct: viewModel.correctCount, total: viewModel.totalQuestions)
        let before = AchievementCatalog.idsUnlocked(using: store)
        let beforeRewards = RewardCatalog.unlockedIds(using: store)
        store.recordSession(
            activity: .landmark,
            level: level,
            starsEarned: stars,
            correctAnswers: viewModel.correctCount,
            durationSeconds: viewModel.elapsedSeconds()
        )
        let afterIds = AchievementCatalog.idsUnlocked(using: store)
        let newOnes = afterIds.subtracting(before)
        let fresh = AchievementCatalog.allUnlocked(using: store).filter { newOnes.contains($0.id) }
        let newRewardIds = RewardCatalog.unlockedIds(using: store).subtracting(beforeRewards)
        let newRewards = newRewardIds.compactMap { RewardCatalog.playerReward(id: $0) }
        let outcome = viewModel.buildOutcome(newAchievements: fresh, newRewards: newRewards)
        path.removeLast()
        path.append(ExplorePath.outcome(outcome))
    }
}

struct CulturalPlayCoordinator: View {
    @EnvironmentObject private var store: ProgressStore
    @Binding var path: NavigationPath
    let level: Int
    let difficulty: Difficulty

    @StateObject private var viewModel: CulturalConundrumsViewModel
    @State private var didFinish = false

    init(path: Binding<NavigationPath>, level: Int, difficulty: Difficulty) {
        _path = path
        self.level = level
        self.difficulty = difficulty
        _viewModel = StateObject(wrappedValue: CulturalConundrumsViewModel(level: level, difficulty: difficulty))
    }

    var body: some View {
        CulturalConundrumsView(viewModel: viewModel)
            .navigationTitle("Level \(level)")
            .navigationBarTitleDisplayMode(.inline)
            .onReceive(viewModel.isFinishedPublisher) { finished in
                guard finished, !didFinish else { return }
                didFinish = true
                completeSessionCultural()
            }
    }

    private func completeSessionCultural() {
        let stars = ScoreRules.starRating(correct: viewModel.correctCount, total: viewModel.totalQuestions)
        let before = AchievementCatalog.idsUnlocked(using: store)
        let beforeRewards = RewardCatalog.unlockedIds(using: store)
        store.recordSession(
            activity: .cultural,
            level: level,
            starsEarned: stars,
            correctAnswers: viewModel.correctCount,
            durationSeconds: viewModel.elapsedSeconds()
        )
        let afterIds = AchievementCatalog.idsUnlocked(using: store)
        let newOnes = afterIds.subtracting(before)
        let fresh = AchievementCatalog.allUnlocked(using: store).filter { newOnes.contains($0.id) }
        let newRewardIds = RewardCatalog.unlockedIds(using: store).subtracting(beforeRewards)
        let newRewards = newRewardIds.compactMap { RewardCatalog.playerReward(id: $0) }
        let outcome = viewModel.buildOutcome(newAchievements: fresh, newRewards: newRewards)
        path.removeLast()
        path.append(ExplorePath.outcome(outcome))
    }
}

struct HistoricalPlayCoordinator: View {
    @EnvironmentObject private var store: ProgressStore
    @Binding var path: NavigationPath
    let level: Int
    let difficulty: Difficulty

    @StateObject private var viewModel: HistoricalHurdlesViewModel
    @State private var didFinish = false

    init(path: Binding<NavigationPath>, level: Int, difficulty: Difficulty) {
        _path = path
        self.level = level
        self.difficulty = difficulty
        _viewModel = StateObject(wrappedValue: HistoricalHurdlesViewModel(level: level, difficulty: difficulty))
    }

    var body: some View {
        HistoricalHurdlesView(viewModel: viewModel)
            .navigationTitle("Level \(level)")
            .navigationBarTitleDisplayMode(.inline)
            .onReceive(viewModel.isFinishedPublisher) { finished in
                guard finished, !didFinish else { return }
                didFinish = true
                completeSessionHistorical()
            }
    }

    private func completeSessionHistorical() {
        let stars = ScoreRules.starRating(correct: viewModel.correctCount, total: viewModel.totalQuestions)
        let before = AchievementCatalog.idsUnlocked(using: store)
        let beforeRewards = RewardCatalog.unlockedIds(using: store)
        store.recordSession(
            activity: .historical,
            level: level,
            starsEarned: stars,
            correctAnswers: viewModel.correctCount,
            durationSeconds: viewModel.elapsedSeconds()
        )
        let afterIds = AchievementCatalog.idsUnlocked(using: store)
        let newOnes = afterIds.subtracting(before)
        let fresh = AchievementCatalog.allUnlocked(using: store).filter { newOnes.contains($0.id) }
        let newRewardIds = RewardCatalog.unlockedIds(using: store).subtracting(beforeRewards)
        let newRewards = newRewardIds.compactMap { RewardCatalog.playerReward(id: $0) }
        let outcome = viewModel.buildOutcome(newAchievements: fresh, newRewards: newRewards)
        path.removeLast()
        path.append(ExplorePath.outcome(outcome))
    }
}

struct ExploreResultCoordinator: View {
    let outcome: SessionOutcome
    @Binding var path: NavigationPath

    var body: some View {
        SessionResultView(
            outcome: outcome,
            onNextLevel: nextLevelAction,
            onRetry: retry,
            onBackToLevels: { path.removeLast() }
        )
    }

    private var nextLevelAction: (() -> Void)? {
        guard outcome.earnedStars >= 1, outcome.levelIndex < ActivityKind.levelCount, !outcome.isMixedChallenge else { return nil }
        return {
            let next = outcome.levelIndex + 1
            let diff = outcome.difficulty
            path.removeLast()
            switch outcome.activity {
            case .landmark:
                path.append(ExplorePath.playLandmark(level: next, difficulty: diff))
            case .cultural:
                path.append(ExplorePath.playCultural(level: next, difficulty: diff))
            case .historical:
                path.append(ExplorePath.playHistorical(level: next, difficulty: diff))
            }
        }
    }

    private func retry() {
        let level = outcome.levelIndex
        let diff = outcome.difficulty
        path.removeLast()
        switch outcome.activity {
        case .landmark:
            path.append(ExplorePath.playLandmark(level: level, difficulty: diff))
        case .cultural:
            path.append(ExplorePath.playCultural(level: level, difficulty: diff))
        case .historical:
            path.append(ExplorePath.playHistorical(level: level, difficulty: diff))
        }
    }
}
