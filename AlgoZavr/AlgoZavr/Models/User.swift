//
//  User.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 03.12.2025.
//


import Foundation

struct User: Identifiable {
    var id: String
    var login: String
    var username: String
    var email: String
    
    static let empty = User(
        id: "",
        login: "",
        username: "",
        email: "",
    )
}
