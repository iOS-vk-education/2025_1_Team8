//
//  TopicsListView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 05.11.2025.
//

import SwiftUI

struct TopicsListView: View {
    @StateObject private var viewModel = LearnViewModel()
    
    @EnvironmentObject private var appState: AppState
    @State private var selectedNav: AlgorithmNav? = nil
    
    @State private var favoritesTopic: Topic? = nil

    private let userAlgorithmsService = UserAlgorithmsServiceFirebase()

    var body: some View {
        List {
            if let favoritesTopic {
                NavigationLink(destination: AlgorithmsListView(topic: favoritesTopic)) {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)

                        Text("Избранные алгоритмы")
                    }
                }
            }

            ForEach(viewModel.topics) { topic in
                NavigationLink(destination: AlgorithmsListView(topic: topic)) {
                    Text(topic.title)
                }
            }
        }
        .navigationTitle("Темы")
        .onAppear {
            viewModel.loadTopics()
            loadFavorites()
            handleOpenAlgorithmNav()
        }
        .onChange(of: appState.openAlgorithmNav) { _ in
            handleOpenAlgorithmNav()
        }
        .navigationDestination(item: $selectedNav) { nav in
            AlgorithmDetailView(
                topicId: nav.topicId,
                algorithmId: nav.algorithmId
            )
        }
    }
    
    private func loadFavorites() {
        Task {
            do {
                let refs = try await userAlgorithmsService
                    .fetchFavoriteAlgorithmRefs(userId: appState.user.id)

                var algorithms: [Algorithm] = []

                for ref in refs {
                    let algorithm = try await userAlgorithmsService.fetchAlgorithm(
                        topicId: ref.topicId,
                        algorithmId: ref.algorithmId
                    )
                    algorithms.append(algorithm)
                }

                favoritesTopic = Topic(
                    id: "favorites",
                    title: "Избранные алгоритмы",
                    algorithms: algorithms
                )
            } catch {
                print("Failed to load favorites:", error)
            }
        }
    }

    private func handleOpenAlgorithmNav() {
        guard let nav = appState.openAlgorithmNav else { return }

        selectedNav = nav

        DispatchQueue.main.async {
            appState.openAlgorithmNav = nil
        }
    }

}

#Preview {
    TopicsListView()
}
