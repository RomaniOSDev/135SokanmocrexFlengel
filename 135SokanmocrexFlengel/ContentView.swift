//
//  ContentView.swift
//  135SokanmocrexFlengel
//


import SwiftUI

struct ContentView: View {
    @StateObject private var store = ProgressStore()

    var body: some View {
        Group {
            if store.hasSeenOnboarding {
                MainTabView()
            } else {
                OnboardingView()
            }
        }
        .environmentObject(store)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
