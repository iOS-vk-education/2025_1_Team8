//
//  AppState.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 04.11.2025.
//


import Foundation
internal import Combine

final class AppState: ObservableObject {

    @Published var isAuthenticated: Bool = false
    @Published var user: User = .empty

    func login(login: String, username: String) {
        user = User(
            username: username,
            login: login,
            email: "\(login)@mail.ru",
            password: "123"
        )
        isAuthenticated = true
    }

    func logout() {
        user = .empty
        isAuthenticated = false
    }
}

