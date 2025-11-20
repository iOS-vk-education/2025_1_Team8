//
//  StartView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 19.11.2025.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()

            Text("Добро пожаловать в AlgoZavr!")
                .font(.system(size: 40, weight: .semibold))
                .multilineTextAlignment(.center)

            Spacer()

            VStack(spacing: 0) {
                NavigationLink {
                    LoginView()
                        .environmentObject(appState)
                } label: {
                    PrimaryButton(title: "Войти")
                }

                NavigationLink {
                    RegisterView()
                        .environmentObject(appState)
                } label: {
                    SecondaryButton(title: "Зарегистрироваться")
                }
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    StartView()
        .environmentObject(AppState())
}
