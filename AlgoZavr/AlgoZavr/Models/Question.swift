//
//  Question.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 21.12.2025.
//


import Foundation

struct QuestionSingle: Identifiable, Codable {
    let id: String
    let topicId: String
    let algorithmId: String

    let difficulty: String

    let prompt: String
    let option1_correct: String
    let option2: String
    let option3: String
    let option4: String
}
