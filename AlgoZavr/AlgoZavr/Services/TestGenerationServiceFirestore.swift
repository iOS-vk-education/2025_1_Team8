//
//  FirestoreTestGenerationService.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 22.12.2025.
//


import FirebaseFirestore
import Foundation

final class TestGenerationServiceFirestore: TestGenerationService {

    private let db = Firestore.firestore()

    func createTest(
        userId: String,
        settings: TestSettings
    ) async throws -> TestAttempt {

        let userRef = db.collection("users").document(userId)

        let userSnap = try await userRef.getDocument()
        guard
            let userData = userSnap.data(),
            var energy = userData["energy"] as? Int,
            energy > 0
        else {
            throw NSError(domain: "NoEnergy", code: 0)
        }

        var learnedAlgorithmIds: Set<String> = []

        if settings.algorithmScope != .all {
            let progressSnap = try await userRef
                .collection("learned_algorithms")
                .getDocuments()

            learnedAlgorithmIds = Set(progressSnap.documents.map { $0.documentID })
        }

        let snapshot = try await db
            .collection("questions")
            .whereField("topicId", in: settings.selectedTopicIds)
            .whereField("difficulty", isEqualTo: settings.difficulty.rawValue)
            .getDocuments()

        var questions: [(id: String, algorithmId: String)] = snapshot.documents.compactMap { doc in
            let data = doc.data()
            guard let algorithmId = data["algorithmId"] as? String else { return nil }
            return (doc.documentID, algorithmId)
        }

        print("Found questions:", questions.count)


        switch settings.algorithmScope {
        case .learned:
            questions = questions.filter { learnedAlgorithmIds.contains($0.algorithmId) }

        case .notLearned:
            questions = questions.filter { !learnedAlgorithmIds.contains($0.algorithmId) }

        case .all:
            break
        }
        
        print("Found questions:", questions.count)
        print("Requested:", settings.questionCount)
        print("Topics:", settings.selectedTopicIds)
        print("Difficulty:", settings.difficulty.rawValue)
        print("Scope:", settings.algorithmScope.rawValue)


        let selected = Array(questions.shuffled().prefix(settings.questionCount))
        guard selected.count == settings.questionCount else {
            throw NSError(domain: "NotEnoughQuestions", code: 0)
        }

        let questionIds = selected.map { $0.id }

        energy -= 1
        try await userRef.updateData(["energy": energy])

        let attemptRef = userRef.collection("testAttempts").document()

        let attempt = TestAttempt(
            id: attemptRef.documentID,
            createdAt: Date(),
            scoreCorrect: 0,
            settings: settings,
            questionIds: questionIds,
            currentIndex: 0
        )

        try await attemptRef.setData([
            "createdAt": Timestamp(date: attempt.createdAt),
            "settings": [
                "questionCount": settings.questionCount,
                "difficulty": settings.difficulty.rawValue,
                "algorithmScope": settings.algorithmScope.rawValue,
                "timerEnabled": settings.timerEnabled,
                "selectedTopicIds": settings.selectedTopicIds
            ],
            "questionIds": questionIds,
            "currentIndex": 0,
            "scoreCorrect": 0
        ])

        return attempt
    }
}
