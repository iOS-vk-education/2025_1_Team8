//
//  RegisterView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 19.11.2025.
//

import SwiftUI

struct RegisterView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var repeatPassword = ""

    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea() // фон потом добавим

            VStack(spacing: 40) {

                // Заголовок
                Text("Регистрация")
                    .font(.system(size: 40, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                // Поля
                VStack(spacing: 16) {
                    GlassField(text: $username, placeholder: "Имя пользователя")
                    GlassField(text: $email, placeholder: "Эл. почта")
                    GlassField(text: $password, placeholder: "Пароль", isSecure: true)
                    GlassField(text: $repeatPassword, placeholder: "Подтверждение пароля", isSecure: true)
                }
                .padding(.horizontal)

                // Кнопка
                PrimaryButton(title: "Зарегистрироваться")
                    .padding(.horizontal)

                Spacer()
            }
            .padding(.top, 40)
        }
        .ignoresSafeArea(.keyboard)
    }
}
