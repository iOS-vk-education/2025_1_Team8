//
//  AppState.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 04.11.2025.
//


import Foundation
internal import Combine

final class AppState: ObservableObject {
    @Published var isAuthenticated = false
}
