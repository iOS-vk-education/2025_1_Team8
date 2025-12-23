//
//  UserAlgorithmsService.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 23.12.2025.
//


protocol UserAlgorithmsService {
    func addToFavorites(topicId: String, algorithmId: String, userId: String) async throws
    func removeFromFavorites(algorithmId: String, userId: String) async throws
    func isFavorite(algorithmId: String, userId: String) async throws -> Bool
    func addToLearned(algorithmId: String, userId: String) async throws
    func removeFromLearned(algorithmId: String, userId: String) async throws
    func isLearned(algorithmId: String, userId: String) async throws -> Bool
    func markAlgorithmActive(topicId: String, algorithmId: String, userId: String
    ) async throws
    func unmarkAlgorithmActive(algorithmId: String, userId: String
    ) async throws
    func fetchAlgorithm(topicId: String, algorithmId: String) async throws -> Algorithm
    func fetchFavoriteAlgorithmRefs(userId: String) async throws -> [(topicId: String, algorithmId: String)]
}
