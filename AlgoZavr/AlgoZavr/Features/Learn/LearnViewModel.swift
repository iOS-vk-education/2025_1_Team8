//
//  LearnViewModel.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 05.11.2025.
//

import Foundation
internal import Combine

struct Topic: Identifiable {
    let id = UUID()
    let title: String
    let algorithms: [String]
}

@MainActor
final class LearnViewModel: ObservableObject {
    @Published var topics: [Topic] = []
    
    func loadTopics() {
        topics = [
            Topic(
                title: "Сортировки",
                algorithms: ["Вставкой", "Выбором", "Пузырьковая", "Слиянием", "Быстрая"]),
            Topic(
                title: "Графы",
                algorithms: ["Поиск в глубину", "Топологическая сортировка", "Поиск в ширину"])
        ]
    }
}
