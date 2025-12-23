//
//  MainTabView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 20.11.2025.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView(selection: $appState.selectedTab) {
            NavigationStack(path: $appState.homePath) {
                HomeView()
                    .navigationDestination(for: HomeRoute.self) { route in
                            switch route {
                            case .testRun(let settings):
                                TestRunView(
                                    userId: appState.user.id,
                                    settings: settings
                                )
                            }
                        }
            }
            .tabItem {
                Label("Главная", systemImage: "house")
            }
            .tag(Tab.home)

            NavigationStack {
                TopicsListView()
            }
            .tabItem {
                Label("Алгоритмы", systemImage: "book")
            }
            .tag(Tab.algorithms)
            
            NavigationStack {
                ProgressScreen()
            }
            .tabItem {
                Label("Прогресс", systemImage: "chart.line.uptrend.xyaxis")
            }
            .tag(Tab.progress)

            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("Профиль", systemImage: "person")
            }
            .tag(Tab.profile)
        }
    }
}
