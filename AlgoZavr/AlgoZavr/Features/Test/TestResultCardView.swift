//
//  TestResultCardView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 23.12.2025.
//

import SwiftUI

struct TestResultCardView: View {
    
    @EnvironmentObject private var appState: AppState

    let correct: Int
    let total: Int
    let XP: Int

    var body: some View {
        VStack(spacing: 18) {

            TestResultCircularView(correct: correct, total: total)
                .padding(.top, 10)

            Text("Вы правильно решили\n\(correct) из \(total) заданий!")
                .multilineTextAlignment(.center)
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(.gray)

            Text("+ \(XP) XP")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(Color(red: 91/255, green: 197/255, blue: 90/255))
                .padding(.top, 6)

            Button {
                appState.homePath = NavigationPath()
            } label: {
                StrokeButton(title: "В главное меню")
                    .frame(height: 52)
            }

        }
        .padding(.horizontal, 20)
        .padding(.bottom, 30)
        .padding(.top, 20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
        )
    }
}
