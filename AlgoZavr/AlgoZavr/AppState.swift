//
//  AppState.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 04.11.2025.
//


import Foundation
internal import Combine
import SwiftUI


enum Tab {
    case home
    case algorithms
    case progress
    case profile
}

enum HomeRoute: Hashable {
    case testRun(TestSettings)
}
    

final class AppState: ObservableObject {

    @Published var isAuthenticated = false
    @Published var user: User = .empty
    @Published var selectedTab: Tab = .home
    @Published var homePath = NavigationPath()
    
    @Published var openAlgorithmNav: AlgorithmNav? = nil


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
    
    @MainActor
    func updateUsername(_ username: String) async {
        user.username = username

        do {
            try await authService.updateUsername(
                userId: user.id,
                username: username
            )
        } catch {
            print("Failed to update username:", error)
        }
    }

    @MainActor
    func updateLogin(_ login: String) async {
        user.login = login

        do {
            try await authService.updateLogin(
                userId: user.id,
                login: login
            )
        } catch {
            print("Failed to update login:", error)
        }
    }

    @MainActor
    func updateAvatar(_ data: Data) async {
        do {
            try await authService.updateAvatar(
                userId: user.id,
                avatarData: data
            )
        } catch {
            print("Failed to update avatar:", error)
        }
    }
    
    @MainActor
    func updateEmail(_ email: String) async {
        user.email = email
        do {
            try await authService.updateEmail(
                userId: user.id,
                email: email
            )
        } catch {
            print("Failed to update email:", error)
        }
    }
}
