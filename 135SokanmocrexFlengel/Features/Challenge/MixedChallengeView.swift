//
//  MixedChallengeView.swift
//  135SokanmocrexFlengel
//

import Combine
import SwiftUI

struct MixedChallengeView: View {
    @ObservedObject var viewModel: MixedChallengeViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                header
                Text(viewModel.currentQuestion.prompt)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(Color.appTextPrimary)
                    .fixedSize(horizontal: false, vertical: true)

                timerBar

                VStack(spacing: 10) {
                    ForEach(Array(viewModel.currentQuestion.options.enumerated()), id: \.offset) { index, option in
                        optionButton(index: index, label: option)
                    }
                }

                if viewModel.showExplanation {
                    explanationBlock
                    continueButton
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .triviaScreenBackground()
        .navigationTitle("Mixed Round")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.startTimerIfNeeded()
        }
        .onDisappear {
            viewModel.stopTimer()
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Mixed Topic Round")
                .font(.headline.weight(.bold))
                .foregroundStyle(Color.appAccent)
            Text(viewModel.difficulty.title)
                .font(.subheadline)
                .foregroundStyle(Color.appTextSecondary)
            Text(viewModel.progressLabel)
                .font(.caption.weight(.medium))
                .foregroundStyle(Color.appTextSecondary)
            ProgressView(value: Double(viewModel.questionIndex + (viewModel.showExplanation ? 1 : 0)), total: Double(viewModel.totalQuestions))
                .tint(Color.appAccent)
            HStack {
                Label("Lives: \(viewModel.livesRemaining)", systemImage: "heart.fill")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.appTextPrimary)
                Spacer()
            }
        }
        .padding(14)
        .triviaElevatedCard(cornerRadius: 18)
    }

    private var timerBar: some View {
        HStack {
            Image(systemName: "timer")
                .foregroundStyle(Color.appAccent)
            Text("Time left: \(viewModel.secondsRemaining)s")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color.appTextPrimary)
            Spacer()
        }
        .padding(12)
        .triviaElevatedCard(cornerRadius: 12)
    }

    private func optionButton(index: Int, label: String) -> some View {
        let selected = viewModel.selectedIndex == index
        let correct = index == viewModel.currentQuestion.correctIndex
        let showResult = viewModel.showExplanation
        let bg: Color = {
            if !showResult { return Color.appSurface }
            if correct { return Color.appPrimary.opacity(0.35) }
            if selected { return Color.red.opacity(0.25) }
            return Color.appSurface.opacity(0.6)
        }()

        return Button {
            viewModel.selectOption(index)
        } label: {
            Text(label)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
                .minimumScaleFactor(0.75)
                .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
                .padding(.horizontal, 14)
                .foregroundStyle(Color.appTextPrimary)
        }
        .disabled(viewModel.showExplanation)
        .background(
            Group {
                if !showResult {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(AppVisualStyle.cardFill)
                } else {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(bg)
                }
            }
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(AppVisualStyle.cardRimLight.opacity(showResult ? 0.2 : 1), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: Color.appTextPrimary.opacity(showResult ? 0 : 0.07), radius: 8, x: 0, y: 3)
    }

    private var explanationBlock: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Explanation")
                .font(.subheadline.weight(.bold))
                .foregroundStyle(Color.appTextPrimary)
            Text(viewModel.currentQuestion.explanation)
                .font(.footnote)
                .foregroundStyle(Color.appTextSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .triviaElevatedCard(cornerRadius: 14)
    }

    private var continueButton: some View {
        Button {
            viewModel.advance()
        } label: {
            Text(viewModel.questionIndex + 1 >= viewModel.totalQuestions || viewModel.livesRemaining <= 0 ? "View Results" : "Continue")
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .buttonStyle(PrimaryTriviaButtonStyle())
    }
}

struct MixedPlayCoordinator: View {
    @EnvironmentObject private var store: ProgressStore
    @Binding var path: NavigationPath
    let difficulty: Difficulty

    @StateObject private var viewModel: MixedChallengeViewModel
    @State private var didFinish = false

    init(path: Binding<NavigationPath>, difficulty: Difficulty) {
        _path = path
        self.difficulty = difficulty
        _viewModel = StateObject(wrappedValue: MixedChallengeViewModel(difficulty: difficulty))
    }

    var body: some View {
        MixedChallengeView(viewModel: viewModel)
            .onReceive(viewModel.isFinishedPublisher) { finished in
                guard finished, !didFinish else { return }
                didFinish = true
                completeSessionMixed()
            }
    }

    private func completeSessionMixed() {
        let stars = ScoreRules.starRating(correct: viewModel.correctCount, total: viewModel.totalQuestions)
        let before = AchievementCatalog.idsUnlocked(using: store)
        let beforeRewards = RewardCatalog.unlockedIds(using: store)
        store.recordChallengeSession(
            starsEarned: stars,
            correctAnswers: viewModel.correctCount,
            durationSeconds: viewModel.elapsedSeconds(),
            difficulty: difficulty
        )
        let afterIds = AchievementCatalog.idsUnlocked(using: store)
        let newOnes = afterIds.subtracting(before)
        let fresh = AchievementCatalog.allUnlocked(using: store).filter { newOnes.contains($0.id) }
        let newRewardIds = RewardCatalog.unlockedIds(using: store).subtracting(beforeRewards)
        let newRewards = newRewardIds.compactMap { RewardCatalog.playerReward(id: $0) }
        let outcome = viewModel.buildOutcome(newAchievements: fresh, newRewards: newRewards)
        path.removeLast()
        path.append(ChallengePath.outcome(outcome))
    }
}

struct ChallengeResultCoordinator: View {
    let outcome: SessionOutcome
    @Binding var path: NavigationPath

    var body: some View {
        SessionResultView(
            outcome: outcome,
            onNextLevel: nil,
            onRetry: {
                let diff = outcome.difficulty
                path.removeLast()
                path.append(ChallengePath.play(diff))
            },
            onBackToLevels: { path.removeLast() },
            backButtonTitle: "Home"
        )
    }
}
