//
//  TopicsLoaderService 2.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 16.12.2025.
//


import Foundation

protocol TopicsLoaderService {
    func loadTopics() async throws -> [Topic]
}
