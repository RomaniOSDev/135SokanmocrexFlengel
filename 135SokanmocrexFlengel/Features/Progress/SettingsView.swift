//
//  SettingsView.swift
//  135SokanmocrexFlengel
//

import StoreKit
import SwiftUI
import UIKit

struct SettingsView: View {
    @EnvironmentObject private var store: ProgressStore
    @Environment(\.dismiss) private var dismiss
    @State private var confirmReset = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Support & legal")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(Color.appTextPrimary)

                VStack(spacing: 12) {
                    settingsActionRow(title: "Rate Us", systemImage: "star.fill") {
                        rateApp()
                    }
                    settingsActionRow(title: "Privacy Policy", systemImage: "hand.raised.fill") {
                        openPolicy()
                    }
                    settingsActionRow(title: "Terms", systemImage: "doc.text.fill") {
                        AppExternalLink.termsOfUse.open()
                    }
                }

                Text("Data & privacy")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(Color.appTextPrimary)

                Text("All progress stays on this device. No account is required, and nothing leaves your phone unless you choose to share a result sheet.")
                    .font(.subheadline)
                    .foregroundStyle(Color.appTextSecondary)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Summary")
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(Color.appTextPrimary)
                    Text("Stars: \(store.totalStarsCollected)")
                        .foregroundStyle(Color.appTextSecondary)
                    Text("Sessions: \(store.totalSessionsCompleted)")
                        .foregroundStyle(Color.appTextSecondary)
                    Text("Play time: \(playTimeString)")
                        .foregroundStyle(Color.appTextSecondary)
                }
                .font(.subheadline)
                .foregroundStyle(Color.appTextSecondary)
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .triviaElevatedCard(cornerRadius: 14)

                Button(role: .destructive) {
                    confirmReset = true
                } label: {
                    Text("Reset All Progress")
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                .buttonStyle(SecondaryTriviaButtonStyle())
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
        .triviaScreenBackground()
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Reset everything?", isPresented: $confirmReset) {
            Button("Cancel", role: .cancel) {}
            Button("Reset", role: .destructive) {
                store.resetAllProgress()
                dismiss()
            }
        } message: {
            Text("This removes stars, unlocks, achievements context, and shows the introduction again.")
        }
    }

    private var playTimeString: String {
        let s = store.totalPlaySeconds
        let m = s / 60
        let r = s % 60
        return "\(m)m \(r)s"
    }

    private func settingsActionRow(title: String, systemImage: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: systemImage)
                    .font(.body.weight(.semibold))
                    .foregroundStyle(Color.appAccent)
                    .frame(width: 28, alignment: .center)
                Text(title)
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(Color.appTextPrimary)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color.appTextSecondary)
            }
            .padding(16)
            .frame(minHeight: 44)
            .triviaElevatedCard(cornerRadius: 14)
        }
        .buttonStyle(.plain)
    }

    private func openPolicy() {
        if let url = URL(string: AppExternalLink.privacyPolicy.rawValue) {
            UIApplication.shared.open(url)
        }
    }

    private func rateApp() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
}
