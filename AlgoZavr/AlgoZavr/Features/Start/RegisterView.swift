//
//  RegisterView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 19.11.2025.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var appState: AppState
    @State private var email = ""
    @State private var login = ""
    @State private var password = ""
    @State private var repeatPassword = ""

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {

                Text("Регистрация")
                    .font(.system(size: 40, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                VStack(spacing: 16) {
                    GlassField(text: $login, placeholder: "Логин")
                    GlassField(text: $login, placeholder: "Эл. почта")
                    GlassField(text: $password, placeholder: "Пароль", isSecure: true)
                    GlassField(text: $repeatPassword, placeholder: "Подтверждение пароля", isSecure: true)
                }
                .padding(.horizontal)

                Button {
                    appState.login(login: login, username: "Name Surname")
                } label: {
                    PrimaryButton(title: "Зерегистрироваться")
                        .padding(16)
                }

                Spacer()
            }
            .padding(.top, 20)
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    RegisterView()
        .environmentObject(AppState())
}
