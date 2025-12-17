//
//  AuthService.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 17.12.2025.
//


import Foundation

protocol AuthService {
    func signUp(
        login: String,
        username: String,
        email: String,
        password: String
    ) async throws -> User

    func signIn(
        login: String,
        password: String
    ) async throws -> User

    func signOut() throws
}
