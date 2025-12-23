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
    private let initialEnergy: Int = 5
    private let initialXP: Int = 0

    func signUp(
        login: String,
        username: String,
        email: String,
        password: String
    ) async throws -> User {

        let result = try await auth.createUser(
            withEmail: email,
            password: password
        )
        let uid = result.user.uid

        let userData: [String: Any] = [
            "login": login,
            "username": username,
            "email": email,
            "energy": initialEnergy,
            "XP": initialXP
        ]

        try await db
            .collection("users")
            .document(uid)
            .setData(userData)

        return User(
            id: uid,
            login: login,
            username: username,
            email: email,
            energy: initialEnergy,
            XP: initialXP,
            avatar: nil
        )
    }

    func signIn(login: String, password: String) async throws -> User {

        let snapshot = try await db
            .collection("users")
            .whereField("login", isEqualTo: login)
            .limit(to: 1)
            .getDocuments()

        guard
            let document = snapshot.documents.first,
            let email = document.get("email") as? String
        else {
            throw AuthError.userNotFound
        }

        try await auth.signIn(
            withEmail: email,
            password: password
        )

        let data = document.data()
        let uid = document.documentID
        
        let avatarData = data["avatar"] as? Data

        return User(
            id: uid,
            login: data["login"] as? String ?? "",
            username: data["username"] as? String ?? "",
            email: email,
            energy: data["energy"] as? Int ?? 0,
            XP: data["XP"] as? Int ?? 0,
            avatar: avatarData
        )
    }

    func signOut() throws {
        try auth.signOut()
    }

    func updateUsername(
        userId: String,
        username: String
    ) async throws {

        try await db
            .collection("users")
            .document(userId)
            .updateData([
                "username": username
            ])
    }

    func updateLogin(
        userId: String,
        login: String
    ) async throws {

        try await db
            .collection("users")
            .document(userId)
            .updateData([
                "login": login
            ])
    }

    func updateAvatar(
        userId: String,
        avatarData: Data
    ) async throws {

        try await db
            .collection("users")
            .document(userId)
            .updateData([
                "avatar": avatarData
            ])
    }

    func updateEmail(
        userId: String,
        email: String
    ) async throws {
        try await db
            .collection("users")
            .document(userId)
            .updateData([
                "email": email
            ])
    }
}
