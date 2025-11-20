//
//  MainTabView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 20.11.2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Главная", systemImage: "house")
            }

            NavigationStack {
                TopicsListView()
            }
            .tabItem {
                Label("Алгоритмы", systemImage: "book")
            }
            
            NavigationStack {
                PlayView()
            }
            .tabItem {
                Label("Прогресс", systemImage: "chart.line.uptrend.xyaxis")
            }

            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("Профиль", systemImage: "person")
            }
        }
    }
}
