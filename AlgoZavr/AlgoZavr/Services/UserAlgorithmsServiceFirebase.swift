//
//  UserAlgorithmsServiceFirebase.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 23.12.2025.
//


import FirebaseFirestore

final class UserAlgorithmsServiceFirebase: UserAlgorithmsService {

    private let db = Firestore.firestore()

    private func favoritesRef(userId: String, algorithmId: String) -> DocumentReference {
        db.collection("users")
            .document(userId)
            .collection("favorite_algorithms")
            .document(algorithmId)
    }

    private func learnedRef(userId: String, algorithmId: String) -> DocumentReference {
        db.collection("users")
            .document(userId)
            .collection("learned_algorithms")
            .document(algorithmId)
    }
    
    private func activeRef(userId: String, algorithmId: String) -> DocumentReference {
        db.collection("users")
            .document(userId)
            .collection("active_algorithms")
            .document(algorithmId)
    }

    func addToFavorites(
        topicId: String,
        algorithmId: String,
        userId: String
    ) async throws {

        try await favoritesRef(userId: userId, algorithmId: algorithmId)
            .setData([
                "addedAt": Timestamp(date: Date()),
                "topicId": topicId
            ])
    }

    func removeFromFavorites(algorithmId: String, userId: String) async throws {
        try await favoritesRef(userId: userId, algorithmId: algorithmId)
            .delete()
    }

    func isFavorite(algorithmId: String, userId: String) async throws -> Bool {
        let snapshot = try await favoritesRef(userId: userId, algorithmId: algorithmId)
            .getDocument()
        return snapshot.exists
    }

    func addToLearned(
        algorithmId: String,
        userId: String
    ) async throws {

        try await learnedRef(userId: userId, algorithmId: algorithmId)
            .setData(
                [
                    "learnedAt": Timestamp(date: Date())
                ],
                merge: true
            )

        try await activeRef(userId: userId, algorithmId: algorithmId)
            .delete()
    }


    func removeFromLearned(algorithmId: String, userId: String) async throws {
        try await learnedRef(userId: userId, algorithmId: algorithmId)
            .delete()
    }

    func isLearned(algorithmId: String, userId: String) async throws -> Bool {
        let snapshot = try await learnedRef(userId: userId, algorithmId: algorithmId)
            .getDocument()
        return snapshot.exists
    }
    
    func markAlgorithmActive(
        topicId: String,
        algorithmId: String,
        userId: String
    ) async throws {

        let learnedRef = db
            .collection("users")
            .document(userId)
            .collection("learned_algorithms")
            .document(algorithmId)

        let learnedSnap = try await learnedRef.getDocument()
        guard !learnedSnap.exists else {
            return
        }

        let ref = db
            .collection("users")
            .document(userId)
            .collection("active_algorithms")
            .document(algorithmId)

        try await ref.setData(
            [
                "openedAt": Timestamp(date: Date()),
                "topicId": topicId
            ],
            merge: true
        )
    }

    
    func unmarkAlgorithmActive(
        algorithmId: String,
        userId: String
    ) async throws {

        let ref = db
            .collection("users")
            .document(userId)
            .collection("active_algorithms")
            .document(algorithmId)

        try await ref.delete()
    }
    
    func fetchAlgorithm(
        topicId: String,
        algorithmId: String
    ) async throws -> Algorithm {

        let snapshot = try await db
            .collection("topics")
            .document(topicId)
            .collection("algorithms")
            .document(algorithmId)
            .getDocument()

        guard
            snapshot.exists,
            let data = snapshot.data()
        else {
            throw NSError(
                domain: "AlgorithmNotFound",
                code: 404,
                userInfo: [NSLocalizedDescriptionKey: "Algorithm not found"]
            )
        }

        return Algorithm(
            id: algorithmId,
            topicId: topicId,
            title: data["title"] as? String ?? "",
            description: data["description"] as? String ?? "",
            implementation: data["implementation"] as? String ?? "",
            difficulty: data["difficulty"] as? String ?? ""
        )
    }
    
    func fetchFavoriteAlgorithmRefs(
        userId: String
    ) async throws -> [(topicId: String, algorithmId: String)] {

        let snapshot = try await db
            .collection("users")
            .document(userId)
            .collection("favorite_algorithms")
            .getDocuments()

        return snapshot.documents.compactMap { doc in
            guard let topicId = doc.get("topicId") as? String else {
                return nil
            }
            return (topicId: topicId, algorithmId: doc.documentID)
        }
    }
}
