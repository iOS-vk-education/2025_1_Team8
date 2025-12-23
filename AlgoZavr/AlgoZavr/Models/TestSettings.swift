//
//  TestSettings.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 21.12.2025.
//


import Foundation

struct TestSettings: Codable, Hashable {
    let questionCount: Int
    let difficulty: QuestionDifficulty
    let algorithmScope: AlgorithmScope
    let timerEnabled: Bool
    let selectedTopicIds: [String]
}
