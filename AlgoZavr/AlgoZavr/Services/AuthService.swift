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
    
    func updateUsername(
        userId: String,
        username: String
    ) async throws

    func updateLogin(
        userId: String,
        login: String
    ) async throws

    func updateAvatar(
        userId: String,
        avatarData: Data
    ) async throws
    
    func updateEmail(
        userId: String,
        email: String
    ) async throws
}
