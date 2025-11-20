//
//  LoginView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 19.11.2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {

                Text("Вход")
                    .font(.system(size: 40, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                VStack(spacing: 16) {
                    GlassField(text: $email, placeholder: "Email")
                    GlassField(text: $password, placeholder: "Пароль", isSecure: true)
                }
                .padding(.horizontal)

                Button {
                    appState.isAuthenticated = true
                } label: {
                    PrimaryButton(title: "Войти")
                        .padding(.horizontal)
                }

                Spacer()

                NavigationLink {
                    RegisterView()
                } label: {
                    SecondaryButton(title: "Создать аккаунт")
                        .padding(.horizontal)
                }

                Spacer()
            }
            .padding(.top, 40)
        }
        .ignoresSafeArea(.keyboard)
    }
}
