//
//  AppState.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 04.11.2025.
//

import Foundation
import Combine

final class AppState: ObservableObject {
    
    @Published var isAuthenticated: Bool = false
    @Published var user: User? = nil
    
    func login(login: String, username: String) {
        self.user = User(login: login, username: username)
        self.isAuthenticated = true
    }
    
    func logout() {
        self.user = nil
        self.isAuthenticated = false
    }
}

