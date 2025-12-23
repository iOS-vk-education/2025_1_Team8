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
        let topicsSnapshot = try await db
            .collection("topics")
            .getDocuments()

        var result: [Topic] = []

        for topicDoc in topicsSnapshot.documents {
            let data = topicDoc.data()

            guard let title = data["title"] as? String else {
                continue
            }

            let algorithmsSnapshot = try await db
                .collection("topics")
                .document(topicDoc.documentID)
                .collection("algorithms")
                .getDocuments()

            let algorithms: [Algorithm] = algorithmsSnapshot.documents.compactMap { algoDoc in
                let data = algoDoc.data()

                guard
                    let title = data["title"] as? String,
                    let description = data["description"] as? String,
                    let implementation = data["implementation"] as? String,
                    let difficulty = data["difficulty"] as? String,
                    let topicId = data["topicId"] as? String
                else {
                    return nil
                }

                return Algorithm(
                    id: algoDoc.documentID,
                    topicId: topicId,
                    title: title,
                    description: description,
                    implementation: implementation,
                    difficulty: difficulty
                )
            }

            result.append(
                Topic(
                    id: topicDoc.documentID,
                    title: title,
                    algorithms: algorithms
                )
            )
        }

        return result
    }
}
