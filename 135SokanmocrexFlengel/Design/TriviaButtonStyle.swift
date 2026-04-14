//
//  TriviaButtonStyle.swift
//  135SokanmocrexFlengel
//

import SwiftUI

struct PrimaryTriviaButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.weight(.semibold))
            .foregroundStyle(Color.appTextPrimary)
            .frame(maxWidth: .infinity, minHeight: 44)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(AppVisualStyle.primaryButtonFill)
                    .opacity(configuration.isPressed ? 0.88 : 1)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [Color.white.opacity(0.35), Color.clear],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 1
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .shadow(color: Color.appPrimary.opacity(configuration.isPressed ? 0.2 : 0.42), radius: 10, x: 0, y: 5)
            .shadow(color: Color.appTextPrimary.opacity(0.08), radius: 4, x: 0, y: 2)
    }
}

struct SecondaryTriviaButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.weight(.semibold))
            .foregroundStyle(Color.appTextPrimary)
            .frame(maxWidth: .infinity, minHeight: 44)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(AppVisualStyle.secondaryButtonFill)
                    .opacity(configuration.isPressed ? 0.92 : 1)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [Color.appAccent.opacity(0.45), Color.appPrimary.opacity(0.2)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .shadow(color: Color.appTextPrimary.opacity(0.07), radius: 8, x: 0, y: 4)
    }
}

struct ScreenChromeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                AppVisualStyle.screenBackdrop()
                    .ignoresSafeArea()
            )
    }
}

extension View {
    func triviaScreenBackground() -> some View {
        modifier(ScreenChromeModifier())
    }
}
