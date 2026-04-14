//
//  LevelGridView.swift
//  135SokanmocrexFlengel
//

import SwiftUI

struct LevelGridView: View {
    let kind: ActivityKind
    @Binding var path: NavigationPath
    @EnvironmentObject private var store: ProgressStore
    @State private var difficulty: Difficulty = .normal

    private var clearedCount: Int {
        (1...ActivityKind.levelCount).filter { store.stars(for: kind, level: $0) >= 1 }.count
    }

    /// First unlocked stage that is not yet a perfect three-star run (main path for the player).
    private var suggestedLevel: Int? {
        for level in 1...ActivityKind.levelCount {
            guard store.isLevelUnlocked(activity: kind, level: level) else { return nil }
            if store.stars(for: kind, level: level) < 3 {
                return level
            }
        }
        return nil
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                ActivityLevelHeader(kind: kind, cleared: clearedCount, total: ActivityKind.levelCount)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Difficulty")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color.appTextSecondary)
                    DifficultySelectorBar(selection: $difficulty)
                    Text("Easy adds hints and extra lives. Hard tightens timers where they apply.")
                        .font(.caption2)
                        .foregroundStyle(Color.appTextSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Text("Levels")
                    .font(.headline.weight(.bold))
                    .foregroundStyle(Color.appTextPrimary)

                VStack(spacing: 0) {
                    ForEach(1...ActivityKind.levelCount, id: \.self) { level in
                        let isLast = level == ActivityKind.levelCount
                        LevelPathRow(
                            level: level,
                            isLastInPath: isLast,
                            difficulty: difficulty,
                            unlocked: store.isLevelUnlocked(activity: kind, level: level),
                            stars: store.stars(for: kind, level: level),
                            isSuggested: suggestedLevel == level
                        ) {
                            startLevel(level)
                        }
                    }
                }
                .padding(.vertical, 4)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .triviaScreenBackground()
        .navigationTitle(kind.displayTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func startLevel(_ level: Int) {
        guard store.isLevelUnlocked(activity: kind, level: level) else { return }
        switch kind {
        case .landmark:
            path.append(ExplorePath.playLandmark(level: level, difficulty: difficulty))
        case .cultural:
            path.append(ExplorePath.playCultural(level: level, difficulty: difficulty))
        case .historical:
            path.append(ExplorePath.playHistorical(level: level, difficulty: difficulty))
        }
    }
}

// MARK: - Header

private struct ActivityLevelHeader: View {
    let kind: ActivityKind
    let cleared: Int
    let total: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 14) {
                ActivityHeaderGlyph(kind: kind)
                    .frame(width: 72, height: 72)
                VStack(alignment: .leading, spacing: 6) {
                    Text("Choose a stage")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Color.appAccent)
                    Text(kind.subtitle)
                        .font(.footnote)
                        .foregroundStyle(Color.appTextSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            HStack(spacing: 10) {
                Label("\(cleared)/\(total) cleared", systemImage: "flag.checkered")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.appTextPrimary)
                Spacer(minLength: 0)
                Text("\(total) stages")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(Color.appTextSecondary)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color.appBackground.opacity(0.55))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            ProgressView(value: Double(cleared), total: Double(total))
                .tint(Color.appPrimary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .triviaElevatedCard(cornerRadius: 20)
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.appAccent.opacity(0.28), lineWidth: 1)
        )
    }
}

private struct ActivityHeaderGlyph: View {
    let kind: ActivityKind
    @State private var pulse = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.appBackground.opacity(0.75))
            Group {
                switch kind {
                case .landmark:
                    LandmarkHeaderShape()
                        .stroke(Color.appAccent, lineWidth: 2)
                case .cultural:
                    CulturalHeaderShape()
                        .stroke(Color.appPrimary, lineWidth: 2)
                case .historical:
                    HistoricalHeaderShape()
                        .stroke(Color.appAccent, lineWidth: 2)
                }
            }
            .scaleEffect(pulse ? 1.03 : 0.97)
            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: pulse)
        }
        .onAppear { pulse = true }
    }
}

private struct LandmarkHeaderShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width
        let h = rect.height
        p.move(to: CGPoint(x: w * 0.5, y: h * 0.15))
        p.addLine(to: CGPoint(x: w * 0.78, y: h * 0.82))
        p.addLine(to: CGPoint(x: w * 0.22, y: h * 0.82))
        p.closeSubpath()
        p.move(to: CGPoint(x: w * 0.35, y: h * 0.55))
        p.addQuadCurve(to: CGPoint(x: w * 0.65, y: h * 0.55), control: CGPoint(x: w * 0.5, y: h * 0.32))
        return p
    }
}

private struct CulturalHeaderShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let c = CGPoint(x: rect.midX, y: rect.midY)
        let r = min(rect.width, rect.height) * 0.36
        p.addEllipse(in: CGRect(x: c.x - r, y: c.y - r, width: 2 * r, height: 2 * r))
        p.move(to: CGPoint(x: c.x - r * 0.35, y: c.y - r * 1.05))
        p.addQuadCurve(to: CGPoint(x: c.x + r * 0.35, y: c.y - r * 1.05), control: CGPoint(x: c.x, y: c.y - r * 1.35))
        return p
    }
}

private struct HistoricalHeaderShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width
        let h = rect.height
        p.addEllipse(in: CGRect(x: w * 0.28, y: h * 0.22, width: w * 0.44, height: h * 0.48))
        p.move(to: CGPoint(x: w * 0.24, y: h * 0.78))
        p.addLine(to: CGPoint(x: w * 0.76, y: h * 0.78))
        p.move(to: CGPoint(x: w * 0.5, y: h * 0.22))
        p.addLine(to: CGPoint(x: w * 0.5, y: h * 0.12))
        return p
    }
}

// MARK: - Difficulty bar

private struct DifficultySelectorBar: View {
    @Binding var selection: Difficulty

    var body: some View {
        HStack(spacing: 8) {
            ForEach(Difficulty.allCases) { mode in
                Button {
                    selection = mode
                } label: {
                    Text(mode.title)
                        .font(.subheadline.weight(.semibold))
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .foregroundStyle(selection == mode ? Color.appTextPrimary : Color.appTextSecondary)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(
                                    selection == mode
                                        ? LinearGradient(
                                            colors: [Color.appPrimary, Color.appPrimary.opacity(0.75)],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                        : LinearGradient(
                                            colors: [Color.appSurface, Color.appBackground.opacity(0.25)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(Color.appAccent.opacity(selection == mode ? 0.35 : 0.2), lineWidth: 1)
                        )
                        .shadow(color: Color.appPrimary.opacity(selection == mode ? 0.25 : 0), radius: 8, x: 0, y: 3)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

// MARK: - Path row

private struct LevelPathRow: View {
    let level: Int
    let isLastInPath: Bool
    let difficulty: Difficulty
    let unlocked: Bool
    let stars: Int
    let isSuggested: Bool
    let onTap: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(spacing: 0) {
                LevelNodeOrb(
                    level: level,
                    unlocked: unlocked,
                    stars: stars,
                    emphasize: unlocked && isSuggested
                )
                if !isLastInPath {
                    PathConnectorLine(active: unlocked)
                        .frame(width: 4, height: 28)
                }
            }
            .frame(width: 52)

            Button(action: onTap) {
                HStack(alignment: .center, spacing: 12) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            Text("Stage \(level)")
                                .font(.headline.weight(.bold))
                                .foregroundStyle(unlocked ? Color.appTextPrimary : Color.appTextSecondary)
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                            if unlocked && isSuggested {
                                Text("Next up")
                                    .font(.caption2.weight(.bold))
                                    .foregroundStyle(Color.appBackground)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 3)
                                    .background(Color.appPrimary)
                                    .clipShape(Capsule())
                            }
                        }
                        HStack(spacing: 5) {
                            ForEach(0..<3, id: \.self) { i in
                                StarShape()
                                    .fill(starFill(for: i))
                                    .frame(width: 16, height: 16)
                            }
                        }
                        Text(statusSubtitle)
                            .font(.caption2)
                            .foregroundStyle(Color.appTextSecondary)
                            .lineLimit(2)
                            .minimumScaleFactor(0.85)
                    }
                    Spacer(minLength: 8)
                    Image(systemName: unlocked ? "chevron.right" : "lock.fill")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(unlocked ? Color.appAccent : Color.appTextSecondary)
                        .frame(width: 28, height: 44)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity, minHeight: 72, alignment: .leading)
                .background(
                    Group {
                        if unlocked {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(AppVisualStyle.cardFill)
                        } else {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(
                                    LinearGradient(
                                        colors: [Color.appSurface.opacity(0.42), Color.appBackground.opacity(0.2)],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                        }
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(borderColor, lineWidth: unlocked && isSuggested ? 2 : 1)
                )
                .shadow(color: Color.appTextPrimary.opacity(unlocked ? 0.07 : 0), radius: 10, x: 0, y: 4)
                .shadow(color: Color.appPrimary.opacity(unlocked && isSuggested ? 0.12 : 0), radius: 16, x: 0, y: 6)
            }
            .buttonStyle(.plain)
            .disabled(!unlocked)
            .padding(.leading, 6)
            .padding(.bottom, isLastInPath ? 0 : 4)
        }
    }

    private var statusSubtitle: String {
        if !unlocked {
            return "Clear the previous stage with at least one star."
        }
        if stars == 0 {
            return "Not cleared yet on \(difficulty.title) — tap to play."
        }
        if stars < 3 {
            return "Best: \(stars) stars. Replay for a perfect run."
        }
        return "Perfect three stars on your best run."
    }

    private var borderColor: Color {
        if unlocked && isSuggested {
            return Color.appPrimary.opacity(0.85)
        }
        return Color.appAccent.opacity(unlocked ? 0.22 : 0.08)
    }

    private func starFill(for index: Int) -> Color {
        if index < stars {
            return Color.appAccent
        }
        return Color.appSurface.opacity(0.45)
    }
}

private struct LevelNodeOrb: View {
    let level: Int
    let unlocked: Bool
    let stars: Int
    let emphasize: Bool
    @State private var glow = false

    var body: some View {
        ZStack {
            if emphasize {
                Circle()
                    .stroke(Color.appPrimary.opacity(0.45), lineWidth: 3)
                    .frame(width: 46, height: 46)
                    .scaleEffect(glow ? 1.12 : 0.92)
                    .opacity(glow ? 0.9 : 0.35)
                    .animation(.easeInOut(duration: 1.1).repeatForever(autoreverses: true), value: glow)
            }
            Circle()
                .fill(unlocked ? Color.appSurface : Color.appBackground.opacity(0.9))
                .frame(width: 40, height: 40)
            Circle()
                .stroke(ringColor, lineWidth: unlocked ? 3 : 2)
                .frame(width: 40, height: 40)
            Text("\(level)")
                .font(.caption.weight(.heavy))
                .foregroundStyle(unlocked ? Color.appTextPrimary : Color.appTextSecondary)
        }
        .frame(width: 52, height: 44)
        .onAppear {
            if emphasize { glow = true }
        }
    }

    private var ringColor: Color {
        if !unlocked { return Color.appTextSecondary.opacity(0.35) }
        if stars >= 3 { return Color.appAccent }
        if stars > 0 { return Color.appPrimary }
        return Color.appAccent.opacity(0.65)
    }
}

private struct PathConnectorLine: View {
    let active: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 2, style: .continuous)
            .fill(
                LinearGradient(
                    colors: [
                        Color.appAccent.opacity(active ? 0.55 : 0.18),
                        Color.appPrimary.opacity(active ? 0.35 : 0.1),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }
}
