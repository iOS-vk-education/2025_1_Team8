//
//  HomeViewModel.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 04.11.2025.
//

import Foundation
internal import Combine


final class HomeViewModel: ObservableObject {
    @Published var username: String = ""

    @Published var currentLevel: Int = 5
    @Published var currentXP: Int = 150
    @Published var xpToNextLevel: Int = 250

    @Published var lastCategory: String = "Поиски"
    @Published var lastAlgorithm: String = "Бинарный поиск"
    @Published var lastDescription: String =
        "Бинарный поиск — это алгоритм поиска элемента в отсортированном массиве..."

    func continueLearning() {
        print("Продолжаем алгоритм: \(lastAlgorithm)")
    }

    func startTest() {
        print("Переходим к тесту…")
    }
}
