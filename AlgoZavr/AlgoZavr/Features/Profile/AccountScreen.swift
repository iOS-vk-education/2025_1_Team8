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
    @State private var newEmail = ""

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
                    title: "Почта",
                    value: appState.user.email,
                    text: $newEmail,
                    isEditing: isEditing
                )
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(16)
            .padding(.top, 16)

            Spacer()
        }
        .padding(.horizontal, 16)
        .background(Color(.systemGray6))
        .navigationTitle("Аккаунт")
    }

    private func startEditing() {
        newLogin = appState.user.login
        newEmail = appState.user.email
        isEditing = true
    }

    private func saveChanges() {
        Task {
            if newLogin != appState.user.login {
                await appState.updateLogin(newLogin)
            }

            if newEmail != appState.user.email {
                await appState.updateEmail(newEmail)
            }

            isEditing = false
        }
    }

    @ViewBuilder
    private func row(
        title: String,
        value: String,
        text: Binding<String>,
        isEditing: Bool
    ) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 17, weight: .semibold))

            Spacer()

            if isEditing {
                TextField("", text: text)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(title == "Почта" ? .emailAddress : .default)
            } else {
                Text(value)
            }
        }
    }
}
