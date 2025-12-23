//
//  LoadedQuestion.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 22.12.2025.
//


struct LoadedQuestion {
    let id: String
    let text: String
    let type: QuestionType
    let options: [Option]

    struct Option: Identifiable {
        let id: String
        let text: String
        let isCorrect: Bool
    }
}
