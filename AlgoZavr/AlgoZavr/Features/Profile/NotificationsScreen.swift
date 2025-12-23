//
//  NotificationsScreen.swift
//  AlgoZavr
//
//  Created by Татьяна Шевякова on 23.12.2025.
//

import SwiftUI

struct NotificationsScreen: View {

    @Environment(\.dismiss) private var dismiss

    @State private var notificationsEnabled = true
    @State private var learningReminders = true
    @State private var dailyStreak = true

    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 24) {

                VStack(spacing: 35) {

                    toggleRow(
                        title: "Разрешить уведомления",
                        isOn: $notificationsEnabled
                    )

                    if notificationsEnabled {

                        toggleRow(
                            title: "Напоминания об обучении",
                            subtitle: "Получать напоминания продолжить обучение",
                            isOn: $learningReminders
                        )

                        toggleRow(
                            title: "Ежедневная серия",
                            subtitle: "Напоминать, чтобы не потерять серию",
                            isOn: $dailyStreak
                        )
                    }
                }
                .padding(16)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.05), radius: 10)

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
        .background(Color(.systemGray6))
        .navigationTitle("Уведомления")
    }

    private func toggleRow(
        title: String,
        subtitle: String? = nil,
        isOn: Binding<Bool>
    ) -> some View {

        HStack(alignment: .top) {

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))

                if let subtitle {
                    Text(subtitle)
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            Toggle("", isOn: isOn)
                .labelsHidden()
        }
    }
}

#Preview {
    NavigationStack {
        NotificationsScreen()
    }
}
