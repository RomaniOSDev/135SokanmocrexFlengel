//
//  HistoricalHurdlesViewModel.swift
//  135SokanmocrexFlengel
//

import Combine
import Foundation

@MainActor
final class HistoricalHurdlesViewModel: ObservableObject {
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
    @Published private(set) var secondsRemaining: Int

    private var timerCancellable: AnyCancellable?

    private(set) lazy var isFinishedPublisher: AnyPublisher<Bool, Never> = {
        $isFinished.removeDuplicates().eraseToAnyPublisher()
    }()

    init(level: Int, difficulty: Difficulty) {
        self.level = level
        self.difficulty = difficulty
        self.items = HistoricalQuestionData.items(for: level)
        self.livesRemaining = difficulty.lives
        self.startedAt = Date()
        let base = difficulty.timedQuestionSeconds
        self.secondsRemaining = difficulty == .easy ? base + 8 : base
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

    func startTimerIfNeeded() {
        guard timerCancellable == nil, !isFinished else { return }
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                Task { @MainActor in
                    self.tickTimer()
                }
            }
    }

    func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }

    private func tickTimer() {
        guard !showExplanation, !isFinished else { return }
        if secondsRemaining > 0 {
            secondsRemaining -= 1
        }
        if secondsRemaining == 0 {
            handleTimeUp()
        }
    }

    private func handleTimeUp() {
        guard !showExplanation else { return }
        selectedIndex = -1
        livesRemaining -= 1
        showExplanation = true
        stopTimer()
    }

    func selectOption(_ index: Int) {
        guard !showExplanation, !isFinished else { return }
        stopTimer()
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
        let base = difficulty.timedQuestionSeconds
        secondsRemaining = difficulty == .easy ? base + 8 : base
        timerCancellable?.cancel()
        timerCancellable = nil
        startTimerIfNeeded()
    }

    func elapsedSeconds() -> TimeInterval {
        Date().timeIntervalSince(startedAt)
    }

    func buildOutcome(newAchievements: [Achievement], newRewards: [PlayerReward]) -> SessionOutcome {
        let total = items.count
        let stars = ScoreRules.starRating(correct: correctCount, total: total)
        let perfect = correctCount == total
        return SessionOutcome(
            activity: .historical,
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
        stopTimer()
        isFinished = true
    }
}
