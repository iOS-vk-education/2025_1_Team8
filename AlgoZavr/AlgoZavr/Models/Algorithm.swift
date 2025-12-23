//
//  Algorithm.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 21.12.2025.
//


import Foundation

struct Algorithm: Identifiable, Codable, Hashable {
    let id: String
    let topicId: String
    let title: String
    let description: String
    let implementation: String
    let difficulty: String
}
