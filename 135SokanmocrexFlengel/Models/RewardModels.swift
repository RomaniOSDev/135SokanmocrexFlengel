//
//  RewardModels.swift
//  135SokanmocrexFlengel
//

import Foundation

enum RewardTier: String, CaseIterable, Hashable {
    case bronze
    case silver
    case gold
    case platinum

    var sortIndex: Int {
        switch self {
        case .bronze: return 0
        case .silver: return 1
        case .gold: return 2
        case .platinum: return 3
        }
    }

    var displayTitle: String {
        rawValue.capitalized
    }
}

struct PlayerReward: Identifiable, Hashable {
    let id: String
    let title: String
    let detail: String
    let tier: RewardTier
}

enum RewardID: String, CaseIterable, Identifiable {
    case firstSteps
    case starVault25
    case starVault60
    case starVault120
    case flawlessFive
    case flawlessFifteen
    case triadExplorer
    case mixedSpark
    case mixedEmber
    case devotedThirty
    case devotedSixty
    case atlasWide

    var id: String { rawValue }

    var playerReward: PlayerReward {
        switch self {
        case .firstSteps:
            return PlayerReward(id: rawValue, title: "First Steps", detail: "Clear your first level in any activity.", tier: .bronze)
        case .starVault25:
            return PlayerReward(id: rawValue, title: "Star Vault I", detail: "Collect 25 stars across all levels.", tier: .bronze)
        case .starVault60:
            return PlayerReward(id: rawValue, title: "Star Vault II", detail: "Collect 60 stars across all levels.", tier: .silver)
        case .starVault120:
            return PlayerReward(id: rawValue, title: "Star Vault III", detail: "Collect 120 stars across all levels.", tier: .gold)
        case .flawlessFive:
            return PlayerReward(id: rawValue, title: "Flawless Wave", detail: "Earn three stars on five different levels.", tier: .silver)
        case .flawlessFifteen:
            return PlayerReward(id: rawValue, title: "Flawless Tide", detail: "Earn three stars on fifteen different levels.", tier: .gold)
        case .triadExplorer:
            return PlayerReward(id: rawValue, title: "Triad Explorer", detail: "Clear at least one level in Landmark, Cultural, and Historical play.", tier: .silver)
        case .mixedSpark:
            return PlayerReward(id: rawValue, title: "Mixed Spark", detail: "Score at least two stars in a Mixed Topic Round on any difficulty.", tier: .bronze)
        case .mixedEmber:
            return PlayerReward(id: rawValue, title: "Mixed Ember", detail: "Score three stars on Mixed Topic Round — Hard.", tier: .gold)
        case .devotedThirty:
            return PlayerReward(id: rawValue, title: "Dedicated Half Hour", detail: "Spend 30 minutes playing in total.", tier: .silver)
        case .devotedSixty:
            return PlayerReward(id: rawValue, title: "Dedicated Hour", detail: "Spend 60 minutes playing in total.", tier: .gold)
        case .atlasWide:
            return PlayerReward(id: rawValue, title: "Wide Atlas", detail: "Clear at least eight levels in each of the three activities.", tier: .platinum)
        }
    }

    func isUnlocked(store: ProgressStore) -> Bool {
        switch self {
        case .firstSteps:
            return store.totalLevelsCompleted >= 1
        case .starVault25:
            return store.totalStarsCollected >= 25
        case .starVault60:
            return store.totalStarsCollected >= 60
        case .starVault120:
            return store.totalStarsCollected >= 120
        case .flawlessFive:
            return store.totalThreeStarLevels >= 5
        case .flawlessFifteen:
            return store.totalThreeStarLevels >= 15
        case .triadExplorer:
            return store.landmarkLevelsCompleted >= 1 && store.culturalLevelsCompleted >= 1 && store.historicalLevelsCompleted >= 1
        case .mixedSpark:
            return Difficulty.allCases.contains { store.challengeBestStars(difficulty: $0) >= 2 }
        case .mixedEmber:
            return store.challengeBestStars(difficulty: .hard) >= 3
        case .devotedThirty:
            return store.totalPlaySeconds >= 1800
        case .devotedSixty:
            return store.totalPlaySeconds >= 3600
        case .atlasWide:
            return store.landmarkLevelsCompleted >= 8 && store.culturalLevelsCompleted >= 8 && store.historicalLevelsCompleted >= 8
        }
    }

    /// Shown under a locked reward to explain progress (English UI strings).
    func progressLine(store: ProgressStore) -> String {
        switch self {
        case .firstSteps:
            return "Finish any level with at least one star."
        case .starVault25:
            return "\(store.totalStarsCollected)/25 stars"
        case .starVault60:
            return "\(store.totalStarsCollected)/60 stars"
        case .starVault120:
            return "\(store.totalStarsCollected)/120 stars"
        case .flawlessFive:
            return "\(store.totalThreeStarLevels)/5 levels with three stars"
        case .flawlessFifteen:
            return "\(store.totalThreeStarLevels)/15 levels with three stars"
        case .triadExplorer:
            let l = store.landmarkLevelsCompleted
            let c = store.culturalLevelsCompleted
            let h = store.historicalLevelsCompleted
            return "Landmark \(l)/1 · Cultural \(c)/1 · Historical \(h)/1 levels cleared"
        case .mixedSpark:
            let best = Difficulty.allCases.map { store.challengeBestStars(difficulty: $0) }.max() ?? 0
            return "Best mixed round: \(best)/2 stars (any difficulty)"
        case .mixedEmber:
            return "Hard mixed best: \(store.challengeBestStars(difficulty: .hard))/3 stars"
        case .devotedThirty:
            let m = store.totalPlaySeconds / 60
            return "\(m)/30 minutes played"
        case .devotedSixty:
            let m = store.totalPlaySeconds / 60
            return "\(m)/60 minutes played"
        case .atlasWide:
            let l = store.landmarkLevelsCompleted
            let c = store.culturalLevelsCompleted
            let h = store.historicalLevelsCompleted
            return "Landmark \(l)/8 · Cultural \(c)/8 · Historical \(h)/8"
        }
    }
}

enum RewardCatalog {
    static func unlockedIds(using store: ProgressStore) -> Set<String> {
        Set(RewardID.allCases.filter { $0.isUnlocked(store: store) }.map(\.rawValue))
    }

    static func playerReward(id: String) -> PlayerReward? {
        guard let rid = RewardID(rawValue: id) else { return nil }
        return rid.playerReward
    }

    static func unlockedCount(using store: ProgressStore) -> Int {
        RewardID.allCases.filter { $0.isUnlocked(store: store) }.count
    }

    static var totalCount: Int { RewardID.allCases.count }

    static var displayOrder: [RewardID] {
        RewardID.allCases.sorted { a, b in
            let ra = a.playerReward
            let rb = b.playerReward
            if ra.tier.sortIndex != rb.tier.sortIndex {
                return ra.tier.sortIndex < rb.tier.sortIndex
            }
            return ra.title < rb.title
        }
    }
}
