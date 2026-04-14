//
//  LandmarkTriviaViewModel.swift
//  135SokanmocrexFlengel
//

import Combine
import Foundation

@MainActor
final class LandmarkTriviaViewModel: ObservableObject {
    let level: Int
    let difficulty: Difficulty
    private let items: [TriviaItem]
    private let startedAt: Date

    @Published private(set) var questionIndex: Int = 0
    @Published private(set) var correctCount: Int = 0
    @Published private(set) var livesRemaining: Int
    @Published private(set) var selectedIndex: Int?
    @Published private(set) var showExplanation: Bool = false
    @Published private(set) var isFinished: Bool = false

    private(set) lazy var isFinishedPublisher: AnyPublisher<Bool, Never> = {
        $isFinished.removeDuplicates().eraseToAnyPublisher()
    }()

    init(level: Int, difficulty: Difficulty) {
        self.level = level
        self.difficulty = difficulty
        self.items = LandmarkQuestionData.items(for: level)
        self.livesRemaining = difficulty.lives
        self.startedAt = Date()
    }

    var totalQuestions: Int { items.count }

    var currentQuestion: TriviaItem {
        items[questionIndex]
    }

    var progressLabel: String {
        "Question \(questionIndex + 1) of \(items.count)"
    }

    var hintText: String? {
        guard difficulty.showsHints else { return nil }
        return currentQuestion.hint
    }

    func selectOption(_ index: Int) {
        guard !showExplanation, !isFinished else { return }
        selectedIndex = index
        let correct = index == currentQuestion.correctIndex
        if correct {
            correctCount += 1
        } else {
            livesRemaining -= 1
        }
        showExplanation = true
    }

    func advance() {
        guard showExplanation else { return }
        if livesRemaining <= 0 {
            finishSession()
            return
        }
        if questionIndex + 1 >= items.count {
            finishSession()
            return
        }
        questionIndex += 1
        selectedIndex = nil
        showExplanation = false
    }

    func elapsedSeconds() -> TimeInterval {
        Date().timeIntervalSince(startedAt)
    }

    func buildOutcome(newAchievements: [Achievement], newRewards: [PlayerReward]) -> SessionOutcome {
        let total = items.count
        let stars = ScoreRules.starRating(correct: correctCount, total: total)
        let perfect = correctCount == total
        return SessionOutcome(
            activity: .landmark,
            levelIndex: level,
            difficulty: difficulty,
            correctCount: correctCount,
            totalQuestions: total,
            elapsedSeconds: elapsedSeconds(),
            earnedStars: stars,
            isPerfectRun: perfect,
            newlyUnlockedAchievements: newAchievements,
            newlyUnlockedRewards: newRewards,
            isMixedChallenge: false
        )
    }

    private func finishSession() {
        isFinished = true
    }
}
