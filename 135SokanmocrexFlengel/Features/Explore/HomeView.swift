//
//  HomeView.swift
//  135SokanmocrexFlengel
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var store: ProgressStore

    private var resumeKind: ActivityKind? {
        HomeViewLogic.resumeActivityKind(store: store)
    }

    private var resumeLevel: Int? {
        guard let kind = resumeKind else { return nil }
        return HomeViewLogic.firstSuggestedLevel(activity: kind, store: store)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HomeHeroHeader()

                HomeStatsGrid(store: store)

                if let kind = resumeKind, let level = resumeLevel {
                    NavigationLink(value: ExplorePath.levels(kind)) {
                        ResumeJourneyCard(activity: kind, stage: level)
                    }
                    .buttonStyle(.plain)
                }

                VStack(alignment: .leading, spacing: 12) {
                    sectionTitle("Topic tracks")
                    Text("Each track has twelve stages. Stars unlock the next stage and sync across difficulties.")
                        .font(.footnote)
                        .foregroundStyle(Color.appTextSecondary)
                        .fixedSize(horizontal: false, vertical: true)

                    ForEach(ActivityKind.allCases) { kind in
                        NavigationLink(value: ExplorePath.levels(kind)) {
                            HomeActivityTrackCard(kind: kind)
                        }
                        .buttonStyle(.plain)
                    }
                }

                HomeChallengeHintCard()
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 28)
        }
        .triviaScreenBackground()
        .navigationTitle("Explore")
        .navigationBarTitleDisplayMode(.large)
    }

    private func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.title3.weight(.bold))
            .foregroundStyle(Color.appTextPrimary)
    }
}

// MARK: - Logic

private enum HomeViewLogic {
    static func firstSuggestedLevel(activity: ActivityKind, store: ProgressStore) -> Int? {
        for level in 1...ActivityKind.levelCount {
            guard store.isLevelUnlocked(activity: activity, level: level) else { return nil }
            if store.stars(for: activity, level: level) < 3 {
                return level
            }
        }
        return nil
    }

    static func resumeActivityKind(store: ProgressStore) -> ActivityKind? {
        for kind in ActivityKind.allCases {
            if firstSuggestedLevel(activity: kind, store: store) != nil {
                return kind
            }
        }
        return nil
    }

    static func formattedPlayTime(seconds: Int) -> String {
        let h = seconds / 3600
        let m = (seconds % 3600) / 60
        if h > 0 {
            return String(format: "%dh %dm", h, m)
        }
        if m > 0 {
            return String(format: "%dm", m)
        }
        return seconds < 60 ? "Under a minute" : "\(m)m"
    }
}

// MARK: - Hero

private struct HomeHeroHeader: View {
    @State private var phase: CGFloat = 0

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.appSurface,
                            Color.appBackground.opacity(0.95),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 168)
                .overlay(
                    ZStack {
                        HomeHeroOrbitalRings(phase: phase)
                            .stroke(Color.appAccent.opacity(0.22), lineWidth: 1.2)
                        HomeHeroOrbitalRings(phase: phase + 0.4)
                            .stroke(Color.appPrimary.opacity(0.18), lineWidth: 1)
                            .scaleEffect(0.78)
                    }
                    .allowsHitTesting(false)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(Color.appAccent.opacity(0.25), lineWidth: 1)
                )

            VStack(alignment: .leading, spacing: 8) {
                Text("Your trivia hub")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(Color.appTextPrimary)
                Text("Learn through landmarks, culture, and history — earn stars, clear stages, and chase perfect runs.")
                    .font(.subheadline)
                    .foregroundStyle(Color.appTextSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(20)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .triviaSoftDepth()
        .onAppear {
            withAnimation(.linear(duration: 18).repeatForever(autoreverses: false)) {
                phase = 1
            }
        }
    }
}

private struct HomeHeroOrbitalRings: Shape {
    var phase: CGFloat

    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var p = Path()
        let c = CGPoint(x: rect.maxX - 48, y: rect.minY + 52)
        let base = min(rect.width, rect.height) * 0.42
        for i in 0..<3 {
            let r = base * (0.35 + CGFloat(i) * 0.18)
            let t = phase * .pi * 2 + CGFloat(i) * 0.4
            let shift = CGPoint(x: cos(t) * 6, y: sin(t) * 6)
            p.addEllipse(in: CGRect(
                x: c.x - r + shift.x,
                y: c.y - r + shift.y,
                width: r * 2,
                height: r * 2
            ))
        }
        return p
    }
}

// MARK: - Stats

private struct HomeStatsGrid: View {
    @ObservedObject var store: ProgressStore

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("At a glance")
                .font(.caption.weight(.semibold))
                .foregroundStyle(Color.appTextSecondary)
                .textCase(.uppercase)
                .tracking(0.6)

            LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 10) {
                HomeStatTile(
                    title: "Stars",
                    value: "\(store.totalStarsCollected)",
                    icon: "star.fill",
                    tint: Color.appAccent
                )
                HomeStatTile(
                    title: "Stages cleared",
                    value: "\(store.totalLevelsCompleted)",
                    icon: "flag.checkered",
                    tint: Color.appPrimary
                )
                HomeStatTile(
                    title: "Sessions",
                    value: "\(store.totalSessionsCompleted)",
                    icon: "bolt.horizontal.fill",
                    tint: Color.appAccent
                )
                HomeStatTile(
                    title: "Play time",
                    value: HomeViewLogic.formattedPlayTime(seconds: store.totalPlaySeconds),
                    icon: "clock.fill",
                    tint: Color.appPrimary
                )
            }
        }
    }
}

private struct HomeStatTile: View {
    let title: String
    let value: String
    let icon: String
    let tint: Color

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3.weight(.semibold))
                .foregroundStyle(tint)
                .frame(width: 40, height: 44)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(Color.appTextSecondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                Text(value)
                    .font(.headline.weight(.bold))
                    .foregroundStyle(Color.appTextPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, minHeight: 72)
        .triviaElevatedCard(cornerRadius: 16)
    }
}

// MARK: - Resume

private struct ResumeJourneyCard: View {
    let activity: ActivityKind
    let stage: Int

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.appPrimary.opacity(0.22))
                    .frame(width: 56, height: 56)
                Image(systemName: "play.fill")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(Color.appTextPrimary)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("Continue")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(Color.appAccent)
                    .textCase(.uppercase)
                Text(activity.displayTitle)
                    .font(.headline.weight(.bold))
                    .foregroundStyle(Color.appTextPrimary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.85)
                Text("Jump back to stage \(stage) — polish your stars or push forward.")
                    .font(.footnote)
                    .foregroundStyle(Color.appTextSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
            Image(systemName: "chevron.right.circle.fill")
                .font(.title2)
                .foregroundStyle(Color.appAccent)
        }
        .padding(18)
        .background(
            LinearGradient(
                colors: [
                    Color.appSurface,
                    Color.appPrimary.opacity(0.18),
                    Color.appSurface.opacity(0.82),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(
                    LinearGradient(
                        colors: [Color.appPrimary.opacity(0.65), Color.appAccent.opacity(0.35)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1.5
                )
        )
        .shadow(color: Color.appPrimary.opacity(0.28), radius: 14, y: 6)
        .shadow(color: Color.appTextPrimary.opacity(0.08), radius: 8, y: 4)
    }
}

// MARK: - Activity cards

private struct HomeActivityTrackCard: View {
    let kind: ActivityKind
    @EnvironmentObject private var store: ProgressStore

    private var cleared: Int {
        (1...ActivityKind.levelCount).filter { store.stars(for: kind, level: $0) >= 1 }.count
    }

    private var starSum: Int {
        (1...ActivityKind.levelCount).reduce(0) { $0 + store.stars(for: kind, level: $1) }
    }

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            HomeActivityGlyph(kind: kind)
                .frame(width: 72, height: 72)

            VStack(alignment: .leading, spacing: 10) {
                Text(kind.displayTitle)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(Color.appTextPrimary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .minimumScaleFactor(0.85)

                Text(kind.subtitle)
                    .font(.caption)
                    .foregroundStyle(Color.appTextSecondary)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(3)

                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("Progress")
                            .font(.caption2.weight(.semibold))
                            .foregroundStyle(Color.appTextSecondary)
                        Spacer()
                        Text("\(cleared)/\(ActivityKind.levelCount)")
                            .font(.caption2.weight(.bold))
                            .foregroundStyle(Color.appAccent)
                    }
                    ProgressView(value: Double(cleared), total: Double(ActivityKind.levelCount))
                        .tint(Color.appPrimary)
                }

                HStack(spacing: 14) {
                    Label("\(starSum) stars", systemImage: "star.fill")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color.appAccent)
                    Spacer(minLength: 0)
                    Text("Open")
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(Color.appPrimary)
                    Image(systemName: "arrow.right")
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(Color.appPrimary)
                }
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .triviaElevatedCard(cornerRadius: 22)
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(
                    LinearGradient(
                        colors: [Color.appAccent.opacity(0.4), Color.appPrimary.opacity(0.22)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        )
    }
}

private struct HomeActivityGlyph: View {
    let kind: ActivityKind
    @State private var animate = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.appBackground.opacity(0.65))
            switch kind {
            case .landmark:
                HomeLandmarkGlyphShape()
                    .stroke(Color.appAccent, lineWidth: 2.2)
                    .scaleEffect(animate ? 1.04 : 0.96)
                    .animation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true), value: animate)
            case .cultural:
                HomeCulturalGlyphShape()
                    .stroke(Color.appPrimary, lineWidth: 2.2)
                    .rotationEffect(.degrees(animate ? 5 : -5))
                    .animation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true), value: animate)
            case .historical:
                HomeHistoricalGlyphShape()
                    .stroke(Color.appAccent, lineWidth: 2.2)
                    .scaleEffect(animate ? 1.05 : 0.94)
                    .animation(.easeInOut(duration: 1.45).repeatForever(autoreverses: true), value: animate)
            }
        }
        .onAppear { animate = true }
    }
}

private struct HomeLandmarkGlyphShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width
        let h = rect.height
        p.move(to: CGPoint(x: w * 0.5, y: h * 0.12))
        p.addLine(to: CGPoint(x: w * 0.72, y: h * 0.88))
        p.addLine(to: CGPoint(x: w * 0.28, y: h * 0.88))
        p.closeSubpath()
        p.move(to: CGPoint(x: w * 0.35, y: h * 0.55))
        p.addQuadCurve(to: CGPoint(x: w * 0.65, y: h * 0.55), control: CGPoint(x: w * 0.5, y: h * 0.35))
        return p
    }
}

private struct HomeCulturalGlyphShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let c = CGPoint(x: rect.midX, y: rect.midY)
        let r = min(rect.width, rect.height) * 0.38
        p.addEllipse(in: CGRect(x: c.x - r, y: c.y - r, width: r * 2, height: r * 2))
        p.move(to: CGPoint(x: c.x - r * 0.2, y: c.y - r * 1.1))
        p.addQuadCurve(to: CGPoint(x: c.x + r * 0.2, y: c.y - r * 1.1), control: CGPoint(x: c.x, y: c.y - r * 1.45))
        return p
    }
}

private struct HomeHistoricalGlyphShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width
        let h = rect.height
        p.addEllipse(in: CGRect(x: w * 0.28, y: h * 0.2, width: w * 0.44, height: h * 0.5))
        p.move(to: CGPoint(x: w * 0.22, y: h * 0.78))
        p.addLine(to: CGPoint(x: w * 0.78, y: h * 0.78))
        p.move(to: CGPoint(x: w * 0.5, y: h * 0.2))
        p.addLine(to: CGPoint(x: w * 0.5, y: h * 0.12))
        return p
    }
}

// MARK: - Challenge hint

private struct HomeChallengeHintCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: "bolt.fill")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(Color.appAccent)
                Text("Mixed rounds")
                    .font(.headline.weight(.bold))
                    .foregroundStyle(Color.appTextPrimary)
            }
            Text("Switch to the Challenge tab for a timed mixed-topic run. Beat your best star rating on each difficulty.")
                .font(.footnote)
                .foregroundStyle(Color.appTextSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .triviaElevatedCard(cornerRadius: 16)
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.appAccent.opacity(0.25), lineWidth: 1)
        )
    }
}
