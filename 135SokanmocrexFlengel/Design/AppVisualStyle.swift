//
//  AppVisualStyle.swift
//  135SokanmocrexFlengel
//

import SwiftUI

enum AppVisualStyle {
    @ViewBuilder
    static func screenBackdrop() -> some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.appBackground,
                    Color.appBackground.opacity(0.94),
                    Color.appPrimary.opacity(0.07),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            RadialGradient(
                colors: [Color.appAccent.opacity(0.16), Color.clear],
                center: UnitPoint(x: 0.88, y: 0.08),
                startRadius: 8,
                endRadius: 340
            )
            RadialGradient(
                colors: [Color.appPrimary.opacity(0.1), Color.clear],
                center: UnitPoint(x: 0.12, y: 0.72),
                startRadius: 16,
                endRadius: 300
            )
        }
    }

    static var cardFill: LinearGradient {
        LinearGradient(
            colors: [
                Color.appSurface,
                Color.appSurface.opacity(0.9),
                Color.appBackground.opacity(0.28),
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    static var cardRimLight: LinearGradient {
        LinearGradient(
            colors: [
                Color.white.opacity(0.2),
                Color.appAccent.opacity(0.22),
                Color.clear,
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    static var primaryButtonFill: LinearGradient {
        LinearGradient(
            colors: [
                Color.appPrimary,
                Color.appPrimary.opacity(0.72),
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    static var secondaryButtonFill: LinearGradient {
        LinearGradient(
            colors: [
                Color.appSurface,
                Color.appBackground.opacity(0.35),
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    static let cardShadowLow = (color: Color.appTextPrimary.opacity(0.1), radius: CGFloat(10), y: CGFloat(5))
    static let cardShadowGlow = (color: Color.appPrimary.opacity(0.14), radius: CGFloat(20), y: CGFloat(10))
}

private struct TriviaElevatedCardModifier: ViewModifier {
    var cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(AppVisualStyle.cardFill)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(AppVisualStyle.cardRimLight, lineWidth: 1)
            )
            .shadow(color: AppVisualStyle.cardShadowLow.color, radius: AppVisualStyle.cardShadowLow.radius, x: 0, y: AppVisualStyle.cardShadowLow.y)
            .shadow(color: AppVisualStyle.cardShadowGlow.color, radius: AppVisualStyle.cardShadowGlow.radius, x: 0, y: AppVisualStyle.cardShadowGlow.y)
    }
}

private struct TriviaSoftDepthModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.appTextPrimary.opacity(0.08), radius: 8, x: 0, y: 4)
            .shadow(color: Color.appAccent.opacity(0.1), radius: 14, x: 0, y: 8)
    }
}

extension View {
    /// Raised card: gradient fill, rim light stroke, layered shadow.
    func triviaElevatedCard(cornerRadius: CGFloat = 16) -> some View {
        modifier(TriviaElevatedCardModifier(cornerRadius: cornerRadius))
    }

    /// Extra depth without changing fill (use after your own background).
    func triviaSoftDepth() -> some View {
        modifier(TriviaSoftDepthModifier())
    }
}
