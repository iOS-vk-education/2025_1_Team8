//
//  ProfileView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 04.11.2025.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Group {
            if let user = appState.user {
                profileData(user)
            } else {
                Text("Log in")
            }
        }
        .navigationTitle("Профиль")
    }
    
    private func profileData(_ user: User) -> some View {
        VStack(spacing: 20) {
            VStack(spacing: 5) {
                Image(user.avatar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 138, height: 138)
                HStack {
                    Text("\(user.username)")
                        .font(.system(size: 22, weight: .bold))
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
                Text(user.login)
                    .font(.system(size: 16, weight: .regular))
            }
            Spacer()
        }.padding(.top, 10)
    }
}


#Preview {
    let appState = AppState()
    appState.user = User(login: "loginPreview", username: "Username Preview")
    
    return NavigationStack {
        ProfileView()
            .environmentObject(appState)
    }
}
