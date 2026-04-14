//
//  TabBarAppearance.swift
//  135SokanmocrexFlengel
//

import UIKit

/// Uses asset catalog names so this file does not depend on `SwiftUI.Color` (avoids clashes with generated color symbols).
enum TabBarAppearance {
    private enum AssetName {
        static let surface = "AppSurface"
        static let textSecondary = "AppTextSecondary"
        static let primary = "AppPrimary"
    }

    static func configure() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        if let surface = UIColor(named: AssetName.surface) {
            appearance.backgroundColor = surface
        }
        let item = UITabBarItemAppearance()
        if let secondary = UIColor(named: AssetName.textSecondary) {
            item.normal.iconColor = secondary
            item.normal.titleTextAttributes = [.foregroundColor: secondary]
        }
        if let primary = UIColor(named: AssetName.primary) {
            item.selected.iconColor = primary
            item.selected.titleTextAttributes = [.foregroundColor: primary]
        }
        appearance.stackedLayoutAppearance = item
        appearance.inlineLayoutAppearance = item
        appearance.compactInlineLayoutAppearance = item
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
