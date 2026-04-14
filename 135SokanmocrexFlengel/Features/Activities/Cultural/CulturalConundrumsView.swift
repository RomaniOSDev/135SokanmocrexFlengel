//
//  CulturalConundrumsView.swift
//  135SokanmocrexFlengel
//

import SwiftUI

struct CulturalConundrumsView: View {
    @ObservedObject var viewModel: CulturalConundrumsViewModel

    var body: some View {
        List {
            Section {
                headerContent
            }
            .listRowBackground(culturalListCardShape())

            Section {
                Text(viewModel.currentQuestion.prompt)
                    .font(Font.title3.weight(.semibold))
                    .foregroundStyle(SwiftUI.Color.appTextPrimary)
                    .fixedSize(horizontal: false, vertical: true)
                    .listRowBackground(culturalListCardShape())
            }

            if let hint = viewModel.hintText {
                Section {
                    Text(hint)
                        .font(Font.subheadline)
                        .foregroundStyle(SwiftUI.Color.appAccent)
                        .listRowBackground(
                            culturalListCardShape()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                                        .stroke(SwiftUI.Color.appAccent.opacity(0.35), lineWidth: 1)
                                )
                        )
                }
            }

            Section {
                ForEach(Array(viewModel.currentQuestion.options.enumerated()), id: \.offset) { index, option in
                    culturalRow(index: index, label: option)
                        .listRowBackground(culturalListCardShape())
                }
            }

            if viewModel.showExplanation {
                Section {
                    explanationContent
                }
                .listRowBackground(culturalListCardShape())

                Section {
                    Button {
                        viewModel.advance()
                    } label: {
                        Text(viewModel.questionIndex + 1 >= viewModel.totalQuestions || viewModel.livesRemaining <= 0 ? "View Results" : "Continue")
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            .frame(maxWidth: .infinity, minHeight: 44)
                    }
                    .buttonStyle(PrimaryTriviaButtonStyle())
                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .listRowBackground(SwiftUI.Color.clear)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .listStyle(.insetGrouped)
        .triviaScreenBackground()
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.startTimerIfNeeded()
        }
        .onDisappear {
            viewModel.stopTimer()
        }
    }

    private func culturalListCardShape() -> some View {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(AppVisualStyle.cardFill)
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(AppVisualStyle.cardRimLight, lineWidth: 1)
            )
            .shadow(color: SwiftUI.Color.appTextPrimary.opacity(0.07), radius: 8, x: 0, y: 4)
    }

    private var headerContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Cultural Conundrums")
                .font(Font.headline.weight(.bold))
                .foregroundStyle(SwiftUI.Color.appAccent)
            Text("Level \(viewModel.level) · \(viewModel.difficulty.title)")
                .font(Font.subheadline)
                .foregroundStyle(SwiftUI.Color.appTextSecondary)
            Text(viewModel.progressLabel)
                .font(Font.caption.weight(.medium))
                .foregroundStyle(SwiftUI.Color.appTextSecondary)
            if viewModel.usesTimer {
                timerBar
            }
            ProgressView(value: Double(viewModel.questionIndex + (viewModel.showExplanation ? 1 : 0)), total: Double(viewModel.totalQuestions))
                .tint(SwiftUI.Color.appAccent)
            HStack {
                Label("Lives: \(viewModel.livesRemaining)", systemImage: "heart.fill")
                    .font(Font.caption.weight(.semibold))
                    .foregroundStyle(SwiftUI.Color.appTextPrimary)
                Spacer()
            }
        }
        .padding(.vertical, 6)
    }

    private var timerBar: some View {
        HStack {
            Image(systemName: "timer")
                .foregroundStyle(SwiftUI.Color.appAccent)
            Text("Time left: \(viewModel.secondsRemaining)s")
                .font(Font.subheadline.weight(.semibold))
                .foregroundStyle(SwiftUI.Color.appTextPrimary)
            Spacer()
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(AppVisualStyle.cardFill)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(SwiftUI.Color.appAccent.opacity(0.38), lineWidth: 1)
        )
        .shadow(color: SwiftUI.Color.appTextPrimary.opacity(0.06), radius: 6, x: 0, y: 3)
    }

    private func culturalRow(index: Int, label: String) -> some View {
        let selected = viewModel.selectedIndex == index
        let correct = index == viewModel.currentQuestion.correctIndex
        let showResult = viewModel.showExplanation

        return Button {
            viewModel.selectOption(index)
        } label: {
            HStack(alignment: .center, spacing: 12) {
                Text(label)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .minimumScaleFactor(0.75)
                    .foregroundStyle(SwiftUI.Color.appTextPrimary)
                Spacer(minLength: 8)
                if showResult, correct {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(SwiftUI.Color.appAccent)
                } else if showResult, selected, !correct {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(SwiftUI.Color.red.opacity(0.85))
                }
            }
            .frame(minHeight: 44)
            .contentShape(Rectangle())
        }
        .disabled(viewModel.showExplanation)
        .animation(.easeInOut(duration: 0.25), value: showResult)
    }

    private var explanationContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Explanation")
                .font(Font.subheadline.weight(.bold))
                .foregroundStyle(SwiftUI.Color.appTextPrimary)
            Text(viewModel.currentQuestion.explanation)
                .font(Font.footnote)
                .foregroundStyle(SwiftUI.Color.appTextSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, 4)
    }
}
