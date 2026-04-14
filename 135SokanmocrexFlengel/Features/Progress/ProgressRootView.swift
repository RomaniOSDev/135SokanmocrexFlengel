//
//  ProgressRootView.swift
//  135SokanmocrexFlengel
//

import SwiftUI

struct ProgressRootView: View {
    @EnvironmentObject private var store: ProgressStore

    var body: some View {
        NavigationStack {
            ProgressHomeView()
        }
    }
}

private struct ProgressHomeView: View {
    @EnvironmentObject private var store: ProgressStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                statsSection

                VStack(alignment: .leading, spacing: 12) {
                    Text("Achievements")
                        .font(.title3.weight(.bold))
                        .foregroundStyle(Color.appTextPrimary)

                    let list = AchievementCatalog.allUnlocked(using: store)
                    if list.isEmpty {
                        Text("Play a few rounds to unlock your first achievement.")
                            .font(.subheadline)
                            .foregroundStyle(Color.appTextSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    } else {
                        ForEach(list) { item in
                            achievementRow(item)
                        }
                    }
                }

                NavigationLink {
                    RewardsView()
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Rewards")
                                .font(.headline.weight(.semibold))
                                .foregroundStyle(Color.appTextPrimary)
                            Text("\(RewardCatalog.unlockedCount(using: store))/\(RewardCatalog.totalCount) unlocked")
                                .font(.caption)
                                .foregroundStyle(Color.appTextSecondary)
                        }
                        Spacer()
                        Image(systemName: "gift.fill")
                            .foregroundStyle(Color.appAccent)
                        Image(systemName: "chevron.right")
                            .foregroundStyle(Color.appTextSecondary)
                    }
                    .padding(16)
                    .frame(minHeight: 44)
                    .triviaElevatedCard(cornerRadius: 14)
                }
                .buttonStyle(.plain)

                NavigationLink {
                    SettingsView()
                } label: {
                    HStack {
                        Text("Settings")
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(Color.appTextPrimary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(Color.appTextSecondary)
                    }
                    .padding(16)
                    .frame(minHeight: 44)
                    .triviaElevatedCard(cornerRadius: 14)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
        .triviaScreenBackground()
        .navigationTitle("Progress")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Statistics")
                .font(.title3.weight(.bold))
                .foregroundStyle(Color.appTextPrimary)
            statRow(title: "Total stars collected", value: "\(store.totalStarsCollected)")
            statRow(title: "Levels cleared", value: "\(store.totalLevelsCompleted)")
            statRow(title: "Sessions completed", value: "\(store.totalSessionsCompleted)")
            statRow(title: "Correct answers (total)", value: "\(store.totalCorrectAnswers)")
            statRow(title: "Play time", value: formattedPlayTime)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .triviaElevatedCard(cornerRadius: 16)
    }

    private var formattedPlayTime: String {
        let s = store.totalPlaySeconds
        let h = s / 3600
        let m = (s % 3600) / 60
        let r = s % 60
        if h > 0 {
            return String(format: "%dh %dm", h, m)
        }
        if m > 0 {
            return String(format: "%dm %ds", m, r)
        }
        return String(format: "%ds", r)
    }

    private func statRow(title: String, value: String) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(Color.appTextSecondary)
            Spacer()
            Text(value)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color.appTextPrimary)
        }
    }

    private func achievementRow(_ item: Achievement) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(item.title)
                .font(.headline.weight(.semibold))
                .foregroundStyle(Color.appAccent)
            Text(item.detail)
                .font(.footnote)
                .foregroundStyle(Color.appTextSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .triviaElevatedCard(cornerRadius: 14)
    }
}
