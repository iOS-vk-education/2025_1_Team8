//
//  LearnViewModel.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 05.11.2025.
//

import Foundation
internal import Combine


@MainActor
final class LearnViewModel: ObservableObject {
    @Published var topics: [Topic] = []
    
    private let loader: TopicsLoaderService = TopicsLoaderServiceFireStore()

    func loadTopics() {
        Task {
            do {
                topics = try await loader.loadTopics()
            } catch {
                print("Error while loading topics:", error)
            }
        }
    }
}
