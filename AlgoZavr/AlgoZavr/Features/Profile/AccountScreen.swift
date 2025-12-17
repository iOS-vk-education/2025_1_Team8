//
//  UserProfile.swift
//  AlgoZavr
//
//  Created by Татьяна Шевякова on 12.12.2025.
//

import SwiftUI

struct AccountScreen: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appState: AppState

    @State private var isEditing = false
    @State private var newLogin = ""
    @State private var newPassword = ""

    var body: some View {
        VStack(alignment: .leading) {

            Button {
                if isEditing {
                    saveChanges()
                } else {
                    startEditing()
                }
            } label: {
                Spacer()
                Text(isEditing ? "Готово" : "Изменить")
                    .foregroundColor(.blue)
            }

            VStack(spacing: 16) {

                row(
                    title: "Логин",
                    value: appState.user.login,
                    text: $newLogin,
                    isEditing: isEditing
                )

                row(
                    title: "Пароль",
                    value: "••••••••",
                    text: $newPassword,
                    isEditing: isEditing,
                    isSecure: true
                )
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(16)
            .padding(.top, 16)

            Button {
                   // delete account
               } label: {
                   Text("Удалить аккаунт")
                       .font(.system(size: 16))
                       .foregroundColor(.red)
               }
               .padding(.top, 24)
               .padding(.horizontal, 16)

               Spacer()
        }
        .padding(.horizontal, 16)
        .background(Color(.systemGray6))
        .navigationTitle("Аккаунт")
    }

    private func startEditing() {
        newLogin = appState.user.login
        newPassword = ""
        isEditing = true
    }

    private func saveChanges() {
        appState.user.login = newLogin

//        if !newPassword.isEmpty {
//            appState.user.password = newPassword
//        }

        isEditing = false
    }

    @ViewBuilder
    private func row(
        title: String,
        value: String,
        text: Binding<String>,
        isEditing: Bool,
        isSecure: Bool = false
    ) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 17, weight: .semibold))

            Spacer()

            if isEditing {
                if isSecure {
                    SecureField("", text: text)
                        .multilineTextAlignment(.trailing)
                } else {
                    TextField("", text: text)
                        .multilineTextAlignment(.trailing)
                }
            } else {
                Text(value)
            }
        }
    }
}

struct AccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AccountScreen()
        }
    }
}
