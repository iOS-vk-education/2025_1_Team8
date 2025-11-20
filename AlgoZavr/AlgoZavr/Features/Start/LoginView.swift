//
//  LoginView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 19.11.2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Вход")
                .font(.largeTitle)
                .padding()

            Button("Войти (заглушка)") {
                appState.isAuthenticated = true
            }
            .padding()
        }
    }
}
