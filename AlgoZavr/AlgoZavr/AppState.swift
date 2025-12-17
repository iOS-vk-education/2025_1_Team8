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
    @Published var user: User = .empty

    private let authService: AuthService = AuthServiceFirebase()

    func login(login: String, password: String) {
        Task {
            do {
                user = try await authService.signIn(
                    login: login,
                    password: password
                )
                isAuthenticated = true
            } catch {
                print("Login error:", error)
            }
        }
    }

    func register(
        login: String,
        username: String,
        email: String,
        password: String
    ) {
        Task {
            do {
                user = try await authService.signUp(
                    login: login,
                    username: username,
                    email: email,
                    password: password
                )
                isAuthenticated = true
            } catch {
                print("Register error:", error)
            }
        }
    }

    func logout() {
        try? authService.signOut()
        user = .empty
        isAuthenticated = false
    }
}
