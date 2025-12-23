//
//  TestGenerationService.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 22.12.2025.
//


import Foundation

protocol TestGenerationService {
    func createTest(
        userId: String,
        settings: TestSettings
    ) async throws -> TestAttempt
}
