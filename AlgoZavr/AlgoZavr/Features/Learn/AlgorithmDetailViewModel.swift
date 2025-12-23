//
//  AlgorithmDetailViewModel.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 23.12.2025.
//


import Foundation
internal import Combine

@MainActor
final class AlgorithmDetailViewModel: ObservableObject {

    @Published private(set) var isFavorite = false
    @Published private(set) var isLearned = false
    
    @Published var algorithm: Algorithm?

    private let service: UserAlgorithmsService = UserAlgorithmsServiceFirebase()
    
    private var topicId: String?
    private var algorithmId: String?
    private var userId: String?

    func configure(topicId: String, algorithmId: String, userId: String) async {
        self.topicId = topicId
        self.algorithmId = algorithmId
        self.userId = userId
        await loadState()
    }

    private func loadState() async {
        guard let algorithmId, let userId else { return }

        do {
            isFavorite = try await service.isFavorite(
                algorithmId: algorithmId,
                userId: userId
            )

            isLearned = try await service.isLearned(
                algorithmId: algorithmId,
                userId: userId
            )
        } catch {
            print("Load state error:", error)
        }
    }

    func toggleFavorite() async {
        guard let topicId, let algorithmId, let userId else { return }

        do {
            if isFavorite {
                try await service.removeFromFavorites(
                    algorithmId: algorithmId,
                    userId: userId
                )
                isFavorite = false
            } else {
                try await service.addToFavorites(
                    topicId: topicId,
                    algorithmId: algorithmId,
                    userId: userId
                )
                isFavorite = true
            }
        } catch {
            print("Toggle favorite error:", error)
        }
    }

    func toggleLearned() async {
        guard let algorithmId, let userId else { return }

        do {
            if isLearned {
                try await service.removeFromLearned(
                    algorithmId: algorithmId,
                    userId: userId
                )
                isLearned = false
            } else {
                try await service.addToLearned(
                    algorithmId: algorithmId,
                    userId: userId
                )
                isLearned = true
                
                try await service.unmarkAlgorithmActive(
                    algorithmId: algorithmId,
                    userId: userId
                )
            }
        } catch {
            print("Toggle learned error:", error)
        }
    }
    
    func markAsActive() async {
        guard let topicId, let algorithmId, let userId else { return }

        do {
            try await service.markAlgorithmActive(
                topicId: topicId,
                algorithmId: algorithmId,
                userId: userId
            )
        } catch {
            print("Failed to mark algorithm active:", error)
        }
    }
    
    func unmarkAsActive() async {
        guard let algorithmId, let userId else { return }

        do {
            try await service.unmarkAlgorithmActive(
                algorithmId: algorithmId,
                userId: userId
            )
        } catch {
            print("Failed to unmark algorithm active:", error)
        }
    }
    
    func loadAlgorithm(topicId: String, algorithmId: String, userId: String) async {
        do {
            let algorithm = try await service.fetchAlgorithm(topicId: topicId, algorithmId: algorithmId)
            self.algorithm = algorithm
        } catch {
            print("Failed to load algorithm:", error)
        }
    }
}
