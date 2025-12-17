//
//  FirestoreTopicsLoaderService.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 16.12.2025.
//


import Foundation
import FirebaseFirestore

final class TopicsLoaderServiceFireStore: TopicsLoaderService {

    private let db = Firestore.firestore()

    func loadTopics() async throws -> [Topic] {
        let snapshot = try await db
            .collection("topics")
            .getDocuments()

        return snapshot.documents.compactMap { doc in
            let data = doc.data()

            guard
                let title = data["title"] as? String,
                let algorithms = data["algorithms"] as? [String]
            else {
                return nil
            }

            return Topic(
                id: doc.documentID,
                title: title,
                algorithms: algorithms
            )
        }
    }
}
