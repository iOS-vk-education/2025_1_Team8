//
//  AlgorithmDetailView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 05.11.2025.
//

import SwiftUI

struct AlgorithmDetailView: View {

    enum Tab: String, CaseIterable {
        case description = "Описание"
        case code = "Код"
    }

    private let initialAlgorithm: Algorithm?
    private let algorithmId: String
    private let topicId: String

    @EnvironmentObject private var appState: AppState
    @StateObject private var viewModel = AlgorithmDetailViewModel()
    @State private var selectedTab: Tab = .description

    init(algorithm: Algorithm) {
        self.initialAlgorithm = algorithm
        self.algorithmId = algorithm.id
        self.topicId = algorithm.topicId
    }

    init(topicId: String, algorithmId: String) {
        self.initialAlgorithm = nil
        self.algorithmId = algorithmId
        self.topicId = topicId
    }

    var body: some View {
        Group {
            if let algorithm = initialAlgorithm {
                content(for: algorithm)
            } else if let algorithm = viewModel.algorithm {
                content(for: algorithm)
            } else {
                loadingView
                .task {
                    await viewModel.loadAlgorithm(
                        topicId: topicId,
                        algorithmId: algorithmId,
                        userId: appState.user.id
                    )
                }
            }
        }
    }

    @ViewBuilder
    private func content(for algorithm: Algorithm) -> some View {
        VStack(spacing: 16) {

            segmentedControl

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    switch selectedTab {
                    case .description:
                        descriptionTab(algorithm)
                    case .code:
                        codeTab(algorithm)
                    }
                }
                .padding(.horizontal)
            }

            bottomButton
        }
        .padding(.top)
        .background(Color(.systemGroupedBackground))
        .navigationTitle(algorithm.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task { await viewModel.toggleFavorite() }
                } label: {
                    Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
                        .foregroundColor(.blue)
                }
            }
        }
        .task {
            await viewModel.configure(
                topicId: algorithm.topicId,
                algorithmId: algorithm.id,
                userId: appState.user.id
            )
            await viewModel.markAsActive()
        }
    }

    private var loadingView: some View {
        VStack(spacing: 12) {
            ProgressView()
            Text("Загрузка алгоритма…")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}

private extension AlgorithmDetailView {

    var segmentedControl: some View {
        Picker("", selection: $selectedTab) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Text(tab.rawValue).tag(tab)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }

    func descriptionTab(_ algorithm: Algorithm) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(algorithm.description)
                .font(.system(size: 16))
                .foregroundColor(.black)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
    }

    func codeTab(_ algorithm: Algorithm) -> some View {
        VStack(alignment: .leading, spacing: 12) {

            Text("Реализация")
                .font(.system(size: 20, weight: .bold))

            ScrollView(.horizontal, showsIndicators: false) {
                Text(algorithm.implementation)
                    .font(.system(size: 14, design: .monospaced))
                    .padding()
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            )
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
    }

    var bottomButton: some View {
        Button {
            Task { await viewModel.toggleLearned() }
        } label: {
            Text(viewModel.isLearned ? "Алгоритм изучен" : "Алгоритм не изучен")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(viewModel.isLearned ? .green : .primary)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(
                            viewModel.isLearned
                            ? Color.green.opacity(0.12)
                            : Color.clear
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(
                            viewModel.isLearned
                            ? Color.green
                            : Color(.systemGray3),
                            lineWidth: 1
                        )
                )
                .padding(.horizontal)
        }
        .padding(.bottom)
    }
}
