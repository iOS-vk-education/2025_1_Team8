//
//  TestAttempt.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 22.12.2025.
//


import Foundation

struct TestAttempt: Identifiable, Codable {
    let id: String
    let createdAt: Date
    var scoreCorrect: Int
    var settings: TestSettings
    var questionIds: [String]
    var currentIndex: Int
}
