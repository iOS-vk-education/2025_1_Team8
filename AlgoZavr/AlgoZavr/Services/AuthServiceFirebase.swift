//
//  AuthServiceFirebase.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 17.12.2025.
//

import FirebaseAuth
import FirebaseFirestore

final class AuthServiceFirebase: AuthService {

    private let auth = Auth.auth()
    private let db = Firestore.firestore()

    private func makeInternalEmail(from login: String) -> String {
        "\(login.lowercased())@algozavr.app"
    }

    func signUp(
        login: String,
        username: String,
        email: String,
        password: String
    ) async throws -> User {

        let internalEmail = makeInternalEmail(from: login)

        let result = try await auth.createUser(
            withEmail: internalEmail,
            password: password
        )
        let uid = result.user.uid

        let userData: [String: Any] = [
            "login": login,
            "username": username,
            "email": email
        ]

        try await db
            .collection("users")
            .document(uid)
            .setData(userData)

        return User(
            id: uid,
            login: login,
            username: username,
            email: email
        )
    }


    func signIn(login: String, password: String) async throws -> User {

        let internalEmail = makeInternalEmail(from: login)
        let result = try await auth.signIn(
            withEmail: internalEmail,
            password: password
        )

        let uid = result.user.uid
        let snapshot = try await db
            .collection("users")
            .document(uid)
            .getDocument()

        guard
            let data = snapshot.data(),
            let login = data["login"] as? String,
            let username = data["username"] as? String,
            let email = data["email"] as? String
        else {
            throw NSError(domain: "UserDataError", code: 0)
        }

        return User(
            id: uid,
            login: login,
            username: username,
            email: email
        )
    }

    func signOut() throws {
        try auth.signOut()
    }
}
