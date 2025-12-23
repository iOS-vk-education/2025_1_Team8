//
//  AlgorithmNav.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 23.12.2025.
//


import Foundation

struct AlgorithmNav: Identifiable, Hashable {
    let topicId: String
    let algorithmId: String

    var id: String { "\(topicId)_\(algorithmId)" }
}
