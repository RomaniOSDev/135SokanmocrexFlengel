//
//  MainTabView.swift
//  135SokanmocrexFlengel
//

import SwiftUI

struct MainTabView: View {
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            ExploreRootView()
                .tabItem {
                    Label("Explore", systemImage: "map.fill")
                }
                .tag(0)

            ChallengeRootView()
                .tabItem {
                    Label("Challenge", systemImage: "bolt.fill")
                }
                .tag(1)

            ProgressRootView()
                .tabItem {
                    Label("Progress", systemImage: "chart.bar.fill")
                }
                .tag(2)
        }
        .tint(Color.appPrimary)
        .onAppear {
            TabBarAppearance.configure()
        }
    }
}
