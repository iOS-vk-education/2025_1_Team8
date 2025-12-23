//
//  HomeViewModel.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 04.11.2025.
//


import Foundation
import FirebaseFirestore
internal import Combine

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var lastCategory: String = ""
    @Published var lastAlgorithm: String = ""
    @Published var lastDescription: String = ""
    
    @Published var activeNav: AlgorithmNav? = nil

    private let db = Firestore.firestore()

    func reloadActiveAlgorithm(userId: String) async {
        do {
            let snap = try await db
                .collection("users")
                .document(userId)
                .collection("active_algorithms")
                .order(by: "openedAt", descending: true)
                .limit(to: 1)
                .getDocuments()

            guard let doc = snap.documents.first else {
                lastCategory = "—"
                lastAlgorithm = "Нет активных алгоритмов"
                lastDescription = ""
                activeNav = nil
                return
            }
            
            let algorithmId = doc.documentID
            let topicId = doc["topicId"] as? String ?? ""
            
            activeNav = topicId.isEmpty ? nil : AlgorithmNav(topicId: topicId, algorithmId: algorithmId)

            let algorithmDoc = try await db
                .collection("topics")
                .document(topicId)
                .collection("algorithms")
                .document(algorithmId)
                .getDocument()

            guard let data = algorithmDoc.data() else {
                return
            }
            
            let topicDoc = try await db
                .collection("topics")
                .document(topicId)
                .getDocument()

            lastCategory = topicDoc.data()?["title"] as? String ?? ""
            
            lastAlgorithm = data["title"] as? String ?? ""
            lastDescription = data["description"] as? String ?? ""

        } catch {
            print("Failed to load last algorithm:", error)
        }
    }
}
