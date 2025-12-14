//
//  AlgoZavrApp.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 04.11.2025.
//

import SwiftUI

@main
struct AlgoZavrApp: App {
    
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            Group {
                if appState.isAuthenticated {
                    MainTabView()
                } else {
                    NavigationStack {
                        StartView()
                    }
                }
            }
            .environmentObject(appState)
        }
    }
}
