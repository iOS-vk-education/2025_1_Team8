//
//  LoginView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 19.11.2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @State private var login = ""
    @State private var password = ""

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {

                Text("Вход")
                    .font(.system(size: 40, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                VStack(spacing: 16) {
                    GlassField(text: $login, placeholder: "Логин")
                    GlassField(text: $password, placeholder: "Пароль", isSecure: true)
                }
                .padding(.horizontal)

                Button {
                    appState.login(login: login, username: "Name Surname")
                } label: {
                    PrimaryButton(title: "Войти")
                }

                NavigationLink {
                    RegisterView()
                        .environmentObject(appState)
                } label: {
                    SecondaryButton(title: "Создать аккаунт")
                        .padding(.horizontal)
                }

                Spacer()
            }
            .padding(.top, 20)
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    LoginView()
        .environmentObject(AppState())
}
