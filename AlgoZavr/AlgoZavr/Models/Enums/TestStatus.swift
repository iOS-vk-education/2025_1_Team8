//
//  TestStatus.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 21.12.2025.
//


enum TestStatus: String, Codable {
    case created
    case inProgress = "in_progress"
    case finished
    case canceled
}