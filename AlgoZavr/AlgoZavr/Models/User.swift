//
//  User.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 03.12.2025.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    var login: String
    var username: String
    var email: String
    var energy: Int
    var XP: Int
    var avatar: Data?
    
    static let empty = User(
        id: "",
        login: "",
        username: "",
        email: "",
        energy: 5,
        XP: 0,
        avatar: nil
    )
}
