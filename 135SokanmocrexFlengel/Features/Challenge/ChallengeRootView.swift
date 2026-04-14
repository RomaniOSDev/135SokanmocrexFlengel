//
//  ChallengeRootView.swift
//  135SokanmocrexFlengel
//

import SwiftUI

struct ChallengeRootView: View {
    @EnvironmentObject private var store: ProgressStore
    @State private var path = NavigationPath()
    @State private var selectedDifficulty: Difficulty = .normal

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Play a fast mixed round that pulls questions from every topic. Beat your best star rating for each difficulty.")
                            .font(.subheadline)
                            .foregroundStyle(Color.appTextSecondary)
                            .fixedSize(horizontal: false, vertical: true)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Difficulty")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(Color.appTextSecondary)
                            Picker("Difficulty", selection: $selectedDifficulty) {
                                ForEach(Difficulty.allCases) { d in
                                    Text(d.title).tag(d)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    .padding(16)
                    .triviaElevatedCard(cornerRadius: 18)

                    bestStarsRow

                    Button {
                        path.append(ChallengePath.play(selectedDifficulty))
                    } label: {
                        Text("Start Mixed Round")
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                    }
                    .buttonStyle(PrimaryTriviaButtonStyle())
                    .padding(.top, 8)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            }
            .triviaScreenBackground()
            .navigationTitle("Challenge")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: ChallengePath.self) { route in
                switch route {
                case .play(let difficulty):
                    MixedPlayCoordinator(path: $path, difficulty: difficulty)
                case .outcome(let outcome):
                    ChallengeResultCoordinator(outcome: outcome, path: $path)
                }
            }
        }
    }

    private var bestStarsRow: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Personal best stars")
                .font(.headline.weight(.semibold))
                .foregroundStyle(Color.appTextPrimary)
            ForEach(Difficulty.allCases) { d in
                HStack {
                    Text(d.title)
                        .foregroundStyle(Color.appTextSecondary)
                    Spacer()
                    HStack(spacing: 4) {
                        let n = store.challengeBestStars(difficulty: d)
                        ForEach(0..<3, id: \.self) { i in
                            StarShape()
                                .fill(i < n ? Color.appAccent : Color.appSurface.opacity(0.45))
                                .frame(width: 16, height: 16)
                        }
                    }
                }
                .padding(.vertical, 6)
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .triviaElevatedCard(cornerRadius: 16)
    }
}
