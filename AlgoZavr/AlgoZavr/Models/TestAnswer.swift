//
//  TestAnswer.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 22.12.2025.
//


import Foundation

struct TestAnswer: Identifiable, Codable {
    let id: String
    let questionId: String

    let selectedOptionIds: [String]
    let isCorrect: Bool

    let answeredAt: Date?
    let timeSpentSec: Int?

    let timedOut: Bool
    let skipped: Bool
}
