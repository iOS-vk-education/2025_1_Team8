//
//  AlgoZavrApp.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 04.11.2025.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct AlgoZavrApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
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
