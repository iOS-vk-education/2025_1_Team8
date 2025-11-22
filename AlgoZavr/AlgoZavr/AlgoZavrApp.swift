//
//  AlgoZavrApp.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 04.11.2025.
//

import SwiftUI

@main
struct AlgorithmApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            if appState.isAuthenticated {
                MainTabView()
                    .environmentObject(appState)
            } else {
                NavigationStack {
                    StartView()
                        .environmentObject(appState)
                }
            }
        }
    }
}
