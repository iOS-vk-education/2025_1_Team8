//
//  TestGenerationError.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 22.12.2025.
//


import Foundation

enum TestGenerationError: Error {
    case notEnoughEnergy
    case notEnoughQuestions(found: Int, needed: Int)
    case invalidSettings
    case userProfileMissing
    case userDataMissing
}
