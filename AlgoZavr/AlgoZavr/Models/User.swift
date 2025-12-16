//
//  User.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 03.12.2025.
//


import Foundation

struct User: Identifiable {
    let id = UUID()

    var username: String
    var login: String
    var email: String
    var password: String
    
    static let empty = User(
            username: "",
            login: "",
            email: "",
            password: ""
        )
}
