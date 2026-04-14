//
//  RewardsView.swift
//  135SokanmocrexFlengel
//

import SwiftUI

struct RewardsView: View {
    @EnvironmentObject private var store: ProgressStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                summaryCard

                Text("Earn rewards by collecting stars, clearing levels, playing mixed rounds, and spending time in the app. Tiers rise from Bronze to Platinum.")
                    .font(.subheadline)
                    .foregroundStyle(Color.appTextSecondary)
                    .fixedSize(horizontal: false, vertical: true)

                ForEach(RewardCatalog.displayOrder, id: \.rawValue) { rid in
                    let reward = rid.playerReward
                    let unlocked = rid.isUnlocked(store: store)
                    let progress = unlocked ? "" : rid.progressLine(store: store)
                    rewardRow(reward: reward, unlocked: unlocked, progress: progress)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
        .triviaScreenBackground()
        .navigationTitle("Rewards")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var summaryCard: some View {
        let u = RewardCatalog.unlockedCount(using: store)
        let t = RewardCatalog.totalCount
        return HStack(spacing: 16) {
            ZStack {
                RewardShieldShape()
                    .fill(Color.appSurface)
                    .frame(width: 56, height: 64)
                    .overlay(
                        RewardShieldShape()
                            .stroke(Color.appAccent, lineWidth: 2)
                    )
                StarShape()
                    .fill(Color.appAccent)
                    .frame(width: 22, height: 22)
            }
            VStack(alignment: .leading, spacing: 6) {
                Text("Reward progress")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.appTextSecondary)
                Text("\(u) of \(t) unlocked")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(Color.appTextPrimary)
                ProgressView(value: Double(u), total: Double(t))
                    .tint(Color.appPrimary)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .triviaElevatedCard(cornerRadius: 16)
    }

    private func rewardRow(reward: PlayerReward, unlocked: Bool, progress: String) -> some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                RewardShieldShape()
                    .fill(unlocked ? tierFill(reward.tier) : Color.appBackground.opacity(0.9))
                    .frame(width: 44, height: 52)
                    .overlay(
                        RewardShieldShape()
                            .stroke(unlocked ? Color.appAccent : Color.appTextSecondary.opacity(0.35), lineWidth: 1.5)
                    )
                if unlocked {
                    Image(systemName: "checkmark")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Color.appTextPrimary)
                } else {
                    Image(systemName: "lock.fill")
                        .font(.caption2)
                        .foregroundStyle(Color.appTextSecondary)
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(reward.title)
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(Color.appTextPrimary)
                    Spacer(minLength: 8)
                    Text(reward.tier.displayTitle)
                        .font(.caption2.weight(.bold))
                        .foregroundStyle(Color.appAccent)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.appBackground.opacity(0.55))
                        .clipShape(Capsule())
                }
                Text(reward.detail)
                    .font(.footnote)
                    .foregroundStyle(Color.appTextSecondary)
                    .fixedSize(horizontal: false, vertical: true)
                if !unlocked, !progress.isEmpty {
                    Text(progress)
                        .font(.caption.weight(.medium))
                        .foregroundStyle(Color.appPrimary)
                }
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .triviaElevatedCard(cornerRadius: 14)
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.appAccent.opacity(unlocked ? 0.32 : 0.1), lineWidth: 1)
        )
    }

    private func tierFill(_ tier: RewardTier) -> Color {
        switch tier {
        case .bronze: return Color.appSurface.opacity(0.95)
        case .silver: return Color.appSurface
        case .gold: return Color.appPrimary.opacity(0.35)
        case .platinum: return Color.appAccent.opacity(0.28)
        }
    }
}

private struct RewardShieldShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width
        let h = rect.height
        let top = CGPoint(x: rect.midX, y: rect.minY + h * 0.08)
        p.move(to: top)
        p.addQuadCurve(
            to: CGPoint(x: rect.maxX - w * 0.08, y: rect.minY + h * 0.22),
            control: CGPoint(x: rect.maxX - w * 0.02, y: rect.minY + h * 0.1)
        )
        p.addLine(to: CGPoint(x: rect.maxX - w * 0.12, y: rect.midY + h * 0.12))
        p.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.maxY),
            control: CGPoint(x: rect.maxX, y: rect.maxY - h * 0.18)
        )
        p.addQuadCurve(
            to: CGPoint(x: rect.minX + w * 0.12, y: rect.midY + h * 0.12),
            control: CGPoint(x: rect.minX, y: rect.maxY - h * 0.18)
        )
        p.addLine(to: CGPoint(x: rect.minX + w * 0.08, y: rect.minY + h * 0.22))
        p.addQuadCurve(
            to: top,
            control: CGPoint(x: rect.minX + w * 0.02, y: rect.minY + h * 0.1)
        )
        p.closeSubpath()
        return p
    }
}
