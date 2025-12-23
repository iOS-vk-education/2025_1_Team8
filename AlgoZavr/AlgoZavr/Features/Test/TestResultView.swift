//
//  TestResultView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 23.12.2025.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject private var appState: AppState
    
    let attempt: TestAttempt
    let viewModel: TestRunViewModel
    let onFinish: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {

            Text("Результат")
                .font(.system(size: 28, weight: .bold))
                .padding(.horizontal, 20)

            TestResultCardView(
                correct: attempt.scoreCorrect,
                total: attempt.questionIds.count,
                XP: attempt.scoreCorrect * 30
            )
            .padding(.horizontal, 16)

            Spacer()
        }
        .padding(.top, 16)
        .background(Color(.systemGray6).ignoresSafeArea())
        .onAppear {
            let XP = attempt.scoreCorrect * 30
            Task {
                do {
                    try await viewModel.saveResultAndAddXP(XP: XP)

                    await MainActor.run {
                        appState.user.XP += XP
                    }

                } catch {
                    print("Failed to save test result:", error)
                }
            }
        }
    }
}
