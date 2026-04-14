//
//  LandmarkTriviaView.swift
//  135SokanmocrexFlengel
//

import SwiftUI

struct LandmarkTriviaView: View {
    @ObservedObject var viewModel: LandmarkTriviaViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                header
                Text(viewModel.currentQuestion.prompt)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(Color.appTextPrimary)
                    .fixedSize(horizontal: false, vertical: true)

                if let hint = viewModel.hintText {
                    Text(hint)
                        .font(.subheadline)
                        .foregroundStyle(Color.appAccent)
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .triviaElevatedCard(cornerRadius: 12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(Color.appAccent.opacity(0.35), lineWidth: 1)
                        )
                }

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
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Landmark Trivia")
                .font(.headline.weight(.bold))
                .foregroundStyle(Color.appAccent)
            Text("Level \(viewModel.level) · \(viewModel.difficulty.title)")
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
                .stroke(AppVisualStyle.cardRimLight.opacity(showResult ? 0.22 : 1), lineWidth: 1)
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
