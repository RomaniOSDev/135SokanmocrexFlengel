//
//  OnboardingView.swift
//  135SokanmocrexFlengel
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var store: ProgressStore
    @State private var page = 0

    private let pageCount = 3

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                onboardingChrome

                TabView(selection: $page) {
                    OnboardingExplorePage()
                        .tag(0)
                    OnboardingChallengePage()
                        .tag(1)
                    OnboardingProgressPage()
                        .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut(duration: 0.35), value: page)

                VStack(spacing: 12) {
                    if page > 0 {
                        Button {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                page -= 1
                            }
                        } label: {
                            Text("Back")
                                .font(.subheadline.weight(.semibold))
                                .frame(maxWidth: .infinity, minHeight: 44)
                        }
                        .buttonStyle(SecondaryTriviaButtonStyle())
                    }

                    Button {
                        if page < pageCount - 1 {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                page += 1
                            }
                        } else {
                            store.completeOnboarding()
                        }
                    } label: {
                        Text(page < pageCount - 1 ? "Continue" : "Start Playing")
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                    }
                    .buttonStyle(PrimaryTriviaButtonStyle())
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 28)
            }
        }
        .triviaScreenBackground()
    }

    private var onboardingChrome: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center) {
                Text("Welcome")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(Color.appTextPrimary)
                Spacer(minLength: 12)
                Button("Skip") {
                    store.completeOnboarding()
                }
                .buttonStyle(.plain)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color.appAccent)
                .padding(.vertical, 6)
                .padding(.leading, 8)
            }

            HStack(spacing: 8) {
                Text("Step \(page + 1) of \(pageCount)")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.appTextSecondary)
                    .monospacedDigit()
                Spacer(minLength: 8)
                Text(OnboardingStep.title(for: page))
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.appPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }

            HStack(spacing: 6) {
                ForEach(0..<pageCount, id: \.self) { index in
                    Capsule()
                        .fill(index == page ? Color.appPrimary : Color.appTextSecondary.opacity(0.25))
                        .frame(width: index == page ? 22 : 8, height: 8)
                        .animation(.easeInOut(duration: 0.25), value: page)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }
}

private enum OnboardingStep {
    static func title(for page: Int) -> String {
        switch page {
        case 0: return "Explore tab"
        case 1: return "Challenge tab"
        case 2: return "Progress tab"
        default: return ""
        }
    }
}

private struct OnboardingExplorePage: View {
    @State private var archProgress: CGFloat = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack {
                    ArchIllustration(progress: archProgress)
                        .stroke(Color.appAccent, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                        .frame(height: 160)
                        .padding()
                }
                .frame(height: 220)
                .triviaElevatedCard(cornerRadius: 24)
                .padding(.horizontal, 16)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Explore")
                        .font(.title2.weight(.bold))
                        .foregroundStyle(Color.appTextPrimary)
                    Text("Three topic tracks (landmarks, culture, history), twelve stages each. Earn stars to unlock the next stage.")
                        .font(.body)
                        .foregroundStyle(Color.appTextSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 24)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.15)) {
                archProgress = 1
            }
        }
    }
}

private struct ArchIllustration: Shape {
    var progress: CGFloat

    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width
        let h = rect.height
        let t = max(0.001, progress)
        p.move(to: CGPoint(x: w * 0.1, y: h * 0.85))
        p.addLine(to: CGPoint(x: w * 0.1 + (w * 0.8) * t, y: h * 0.85))
        if t > 0.35 {
            let u = min(1, (t - 0.35) / 0.65)
            p.addQuadCurve(
                to: CGPoint(x: w * 0.5, y: h * 0.15 + (h * 0.35) * (1 - u)),
                control: CGPoint(x: w * 0.25 + w * 0.25 * u, y: h * 0.2)
            )
            p.addQuadCurve(
                to: CGPoint(x: w * 0.9, y: h * 0.85),
                control: CGPoint(x: w * 0.75, y: h * 0.2)
            )
        }
        return p
    }
}

private struct OnboardingChallengePage: View {
    @State private var globeSpin = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack {
                    GlobeIllustration()
                        .stroke(Color.appPrimary, lineWidth: 2.5)
                        .frame(width: 160, height: 160)
                        .rotationEffect(.degrees(globeSpin ? 360 : 0))
                        .animation(.easeInOut(duration: 6).repeatForever(autoreverses: false), value: globeSpin)
                }
                .frame(height: 220)
                .triviaElevatedCard(cornerRadius: 24)
                .padding(.horizontal, 16)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Challenge")
                        .font(.title2.weight(.bold))
                        .foregroundStyle(Color.appTextPrimary)
                    Text("Open the Challenge tab for timed mixed rounds. Pick a difficulty and try to beat your best star rating.")
                        .font(.body)
                        .foregroundStyle(Color.appTextSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 24)
        }
        .onAppear {
            globeSpin = true
        }
    }
}

private struct GlobeIllustration: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let c = CGPoint(x: rect.midX, y: rect.midY)
        let r = min(rect.width, rect.height) / 2
        p.addEllipse(in: CGRect(x: c.x - r, y: c.y - r, width: 2 * r, height: 2 * r))
        for i in 1..<4 {
            let inset = CGFloat(i) * r * 0.22
            p.addEllipse(in: CGRect(x: c.x - (r - inset), y: c.y - (r - inset) * 0.6, width: 2 * (r - inset), height: 1.2 * (r - inset)))
        }
        p.move(to: CGPoint(x: c.x - r, y: c.y))
        p.addLine(to: CGPoint(x: c.x + r, y: c.y))
        p.move(to: CGPoint(x: c.x, y: c.y - r))
        p.addLine(to: CGPoint(x: c.x, y: c.y + r))
        return p
    }
}

private struct OnboardingProgressPage: View {
    @State private var dialPulse = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack {
                    DialIllustration()
                        .stroke(Color.appAccent, lineWidth: 3)
                        .frame(width: 150, height: 150)
                        .scaleEffect(dialPulse ? 1.06 : 0.94)
                        .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: dialPulse)
                }
                .frame(height: 220)
                .triviaElevatedCard(cornerRadius: 24)
                .padding(.horizontal, 16)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Progress")
                        .font(.title2.weight(.bold))
                        .foregroundStyle(Color.appTextPrimary)
                    Text("The Progress tab shows your stats, achievements, rewards, and settings—everything in one place.")
                        .font(.body)
                        .foregroundStyle(Color.appTextSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 24)
        }
        .onAppear {
            dialPulse = true
        }
    }
}

private struct DialIllustration: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let c = CGPoint(x: rect.midX, y: rect.midY)
        let r = min(rect.width, rect.height) / 2
        p.addEllipse(in: CGRect(x: c.x - r, y: c.y - r, width: 2 * r, height: 2 * r))
        for i in 0..<12 {
            let a = CGFloat(i) / 12 * .pi * 2 - .pi / 2
            let inner = r * 0.72
            let outer = r * 0.92
            p.move(to: CGPoint(x: c.x + cos(a) * inner, y: c.y + sin(a) * inner))
            p.addLine(to: CGPoint(x: c.x + cos(a) * outer, y: c.y + sin(a) * outer))
        }
        p.move(to: c)
        p.addLine(to: CGPoint(x: c.x + r * 0.55, y: c.y - r * 0.2))
        return p
    }
}
