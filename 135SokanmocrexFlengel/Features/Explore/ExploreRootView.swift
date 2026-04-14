//
//  ExploreRootView.swift
//  135SokanmocrexFlengel
//

import SwiftUI

struct ExploreRootView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            HomeView()
                .navigationDestination(for: ExplorePath.self) { route in
                    switch route {
                    case .levels(let kind):
                        LevelGridView(kind: kind, path: $path)
                    case .playLandmark(let level, let difficulty):
                        LandmarkPlayCoordinator(path: $path, level: level, difficulty: difficulty)
                    case .playCultural(let level, let difficulty):
                        CulturalPlayCoordinator(path: $path, level: level, difficulty: difficulty)
                    case .playHistorical(let level, let difficulty):
                        HistoricalPlayCoordinator(path: $path, level: level, difficulty: difficulty)
                    case .outcome(let outcome):
                        ExploreResultCoordinator(outcome: outcome, path: $path)
                    }
                }
        }
    }
}
