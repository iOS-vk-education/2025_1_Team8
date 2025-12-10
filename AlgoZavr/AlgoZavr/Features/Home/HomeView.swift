//
//  HomeView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 04.11.2025.
//

import SwiftUI

struct HomeView: View {

    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 40) {

            VStack(alignment: .leading, spacing: 15) {

                LevelCardView(
                    level: viewModel.currentLevel,
                    currentXP: viewModel.currentXP,
                    totalXP: viewModel.xpToNextLevel
                )

                NavigationLink {
                    // Экран продолжения обучения
                } label: {
                    ContinueLearningCard(
                        category: viewModel.lastCategory,
                        algorithm: viewModel.lastAlgorithm,
                        description: viewModel.lastDescription
                    )
                }
                .buttonStyle(.plain)

            }
            .padding(.horizontal)

            VStack(spacing: 15) {

                NavigationLink {
                    TakeTest()
                } label: {
                    PrimaryButton(title: "Пройти тест", icon: "bolt.fill")
                }

                NavigationLink {
                    QuickTest()
                } label: {
                    PrimaryButton(title: "Быстрое повторение", icon: "bolt.fill")
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)

            Spacer()
        }
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationTitle("Главная")
    }
}

struct LevelCardView: View {

    let level: Int
    let currentXP: Int
    let totalXP: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack {
                HStack(spacing: 2) {
                    ForEach(0..<level, id: \.self) { _ in
                        Image(systemName: "bolt.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 20))
                    }
                    ForEach(0..<max(0, 5 - level), id: \.self) { _ in
                        Image(systemName: "bolt")
                            .foregroundColor(.yellow)
                            .font(.system(size: 20))
                    }
                }
                Spacer()

                Text("Уровень \(level)")
                    .font(.system(size: 16, weight: .semibold))
            }

            VStack(spacing: 12) {

                Text("\(currentXP)/\(totalXP) XP")
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)

                ProgressView(value: Double(currentXP), total: Double(totalXP))
                    .progressViewStyle(.linear)
                    .tint(.blue)
                    .scaleEffect(x: 1, y: 1.5, anchor: .center)

                Text("До следующего уровня: \(totalXP - currentXP) XP")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
            }

        }
        .padding(.horizontal, 15)
        .padding(.bottom, 30)
        .padding(.top, 15)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
        )
    }
}

struct ContinueLearningCard: View {

    let category: String
    let algorithm: String
    let description: String

    var body: some View {
        HStack(spacing: 8) {

            VStack(alignment: .leading, spacing: 12) {
                Text("Продолжить обучение")
                    .font(.system(size: 20, weight: .bold))

                Text("\(category) → \(algorithm)")
                    .font(.system(size: 16))

                Text(description)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .lineLimit(3)
            }
            .padding(16)

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)

            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
        }
    }
}
