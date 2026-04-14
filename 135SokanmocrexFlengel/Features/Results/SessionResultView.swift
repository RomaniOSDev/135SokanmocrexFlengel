//
//  SessionResultView.swift
//  135SokanmocrexFlengel
//

import SwiftUI

struct SessionResultView: View {
    let outcome: SessionOutcome
    var onNextLevel: (() -> Void)?
    let onRetry: () -> Void
    let onBackToLevels: () -> Void
    var backButtonTitle: String = "Back to Levels"

    @State private var bannerOffset: CGFloat = -200
    @State private var bannerOpacity: Double = 0
    @State private var revealedStars = 0
    @State private var showShare = false

    private var accuracyText: String {
        let p = ScoreRules.completionPercent(correct: outcome.correctCount, total: outcome.totalQuestions)
        return "\(p)%"
    }

    private var timeText: String {
        let s = Int(outcome.elapsedSeconds.rounded())
        let m = s / 60
        let r = s % 60
        return String(format: "%d:%02d", m, r)
    }

    private var shareMessage: String {
        if outcome.isMixedChallenge {
            return "Mixed round: \(outcome.correctCount)/\(outcome.totalQuestions) correct, \(outcome.earnedStars) stars — difficulty \(outcome.difficulty.title)."
        }
        return "\(outcome.activity.displayTitle) — Level \(outcome.levelIndex): \(outcome.correctCount)/\(outcome.totalQuestions) correct, \(outcome.earnedStars) stars."
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if !outcome.newlyUnlockedAchievements.isEmpty {
                    achievementBanner
                        .offset(y: bannerOffset)
                        .opacity(bannerOpacity)
                }

                if !outcome.newlyUnlockedRewards.isEmpty {
                    rewardBanner
                        .offset(y: bannerOffset)
                        .opacity(bannerOpacity)
                }

                Text("Session Complete")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(Color.appTextPrimary)

                Text(outcome.isMixedChallenge ? "Mixed Topic Round" : outcome.activity.displayTitle)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(Color.appAccent)

                starRow

                statsCard

                VStack(spacing: 12) {
                    if let onNextLevel, outcome.earnedStars >= 1, outcome.levelIndex < ActivityKind.levelCount, !outcome.isMixedChallenge {
                        Button(action: onNextLevel) {
                            Text("Next Level")
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                        }
                        .buttonStyle(PrimaryTriviaButtonStyle())
                    }

                    Button(action: onRetry) {
                        Text("Retry")
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                    }
                    .buttonStyle(SecondaryTriviaButtonStyle())

                    Button(action: onBackToLevels) {
                        Text(backButtonTitle)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                    }
                    .buttonStyle(SecondaryTriviaButtonStyle())

                    Button {
                        showShare = true
                    } label: {
                        Text("Share Result")
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                    }
                    .buttonStyle(PrimaryTriviaButtonStyle())
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
        }
        .triviaScreenBackground()
        .navigationTitle("Results")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showShare) {
            ActivityShareSheet(items: [shareMessage])
        }
        .onAppear {
            animateEntrance()
        }
    }

    private var achievementBanner: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("New Achievement")
                .font(.headline.weight(.bold))
                .foregroundStyle(Color.appTextPrimary)
            ForEach(outcome.newlyUnlockedAchievements) { item in
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Color.appAccent)
                    Text(item.detail)
                        .font(.caption)
                        .foregroundStyle(Color.appTextSecondary)
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .triviaElevatedCard(cornerRadius: 16)
    }

    private var rewardBanner: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("New Reward")
                .font(.headline.weight(.bold))
                .foregroundStyle(Color.appTextPrimary)
            ForEach(outcome.newlyUnlockedRewards) { item in
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Text(item.title)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Color.appPrimary)
                        Text(item.tier.displayTitle)
                            .font(.caption2.weight(.bold))
                            .foregroundStyle(Color.appAccent)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.appBackground.opacity(0.5))
                            .clipShape(Capsule())
                    }
                    Text(item.detail)
                        .font(.caption)
                        .foregroundStyle(Color.appTextSecondary)
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .triviaElevatedCard(cornerRadius: 16)
    }

    private var starRow: some View {
        HStack(spacing: 20) {
            ForEach(0..<3, id: \.self) { index in
                let filled = index < outcome.earnedStars && index < revealedStars
                StarShape()
                    .fill(
                        filled
                            ? LinearGradient(
                                colors: [Color.appAccent, Color.appPrimary.opacity(0.85)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            : LinearGradient(
                                colors: [Color.appSurface.opacity(0.65), Color.appBackground.opacity(0.35)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                    )
                    .frame(width: 56, height: 56)
                    .scaleEffect(filled ? 1 : 0.92)
                    .shadow(color: filled ? Color.appAccent.opacity(0.9) : .clear, radius: filled ? 14 : 0)
                    .shadow(color: filled ? Color.appPrimary.opacity(0.5) : .clear, radius: filled ? 6 : 0)
                    .animation(.spring(response: 0.55, dampingFraction: 0.62), value: revealedStars)
            }
        }
        .padding(.vertical, 18)
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity)
        .triviaElevatedCard(cornerRadius: 22)
    }

    private var statsCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            statRow(title: "Accuracy", value: accuracyText)
            statRow(title: "Time", value: timeText)
            statRow(title: "Completion", value: "\(outcome.correctCount)/\(outcome.totalQuestions)")
            if outcome.isPerfectRun {
                Text("Perfect accuracy on every question you answered.")
                    .font(.footnote.weight(.medium))
                    .foregroundStyle(Color.appAccent)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .triviaElevatedCard(cornerRadius: 16)
    }

    private func statRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(Color.appTextSecondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
                .foregroundStyle(Color.appTextPrimary)
        }
    }

    private func animateEntrance() {
        revealedStars = 0
        let earned = outcome.earnedStars
        if earned > 0 {
            for step in 1...earned {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(step - 1) * 0.15) {
                    withAnimation(.spring(response: 0.55, dampingFraction: 0.62)) {
                        revealedStars = step
                    }
                }
            }
        } else {
            revealedStars = 3
        }
        if !outcome.newlyUnlockedAchievements.isEmpty || !outcome.newlyUnlockedRewards.isEmpty {
            withAnimation(.easeInOut(duration: 0.45)) {
                bannerOffset = 0
                bannerOpacity = 1
            }
        }
    }
}
