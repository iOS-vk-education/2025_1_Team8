//
//  Topic.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 16.12.2025.
//

import Foundation

struct Topic: Identifiable, Codable {
    let id: String
    let title: String
    let algorithms: [Algorithm]
}
