//
//  TakeTestViewModel.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 22.12.2025.
//


import Foundation
internal import Combine

@MainActor
final class TakeTestViewModel: ObservableObject {

    @Published var questionCount: Int = 10
    @Published var selectedDifficulty: String = "Нормальная"
    @Published var selectedAlgorithms: String = "Изученные"
    @Published var timerEnabled: Bool = false

    @Published var topicsSelection: [String: Bool] = [:]

    @Published var topicOrder: [String] = []

    let difficulties = ["Легкая", "Нормальная", "Сложная"]
    let algorithmTypes = ["Все", "Изученные", "Неизученные"]

    var selectedTopicIds: [String] {
        topicOrder.filter { topicsSelection[$0] == true }
    }

    var canStartTest: Bool {
        !selectedTopicIds.isEmpty
    }

    func updateTopics(_ topics: [Topic]) {
        let ids = topics.map { $0.id }
        topicOrder = ids

        for id in ids where topicsSelection[id] == nil {
            topicsSelection[id] = false
        }

        topicsSelection.keys
            .filter { !ids.contains($0) }
            .forEach { topicsSelection.removeValue(forKey: $0) }
    }

    func selectAllTopics() {
        topicOrder.forEach { topicsSelection[$0] = true }
    }

    func clearTopicsSelection() {
        topicOrder.forEach { topicsSelection[$0] = false }
    }

    func makeSettings() -> TestSettings {
        TestSettings(
            questionCount: questionCount,
            difficulty: mappedDifficulty,
            algorithmScope: mappedAlgorithmScope,
            timerEnabled: timerEnabled,
            selectedTopicIds: selectedTopicIds
        )
    }

    private var mappedDifficulty: QuestionDifficulty {
        switch selectedDifficulty {
        case "Легкая": return .easy
        case "Сложная": return .hard
        default: return .normal
        }
    }

    private var mappedAlgorithmScope: AlgorithmScope {
        switch selectedAlgorithms {
        case "Изученные": return .learned
        case "Неизученные": return .notLearned
        default: return .all
        }
    }
}
