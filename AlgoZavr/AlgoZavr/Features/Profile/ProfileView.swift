//
//  ProfileView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 04.11.2025.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {

    @EnvironmentObject var appState: AppState

    @State private var avatarImage: Image = Image(systemName: "photo.circle")
    @State private var selectedPhoto: PhotosPickerItem?

    @State private var isEditingName = false
    @FocusState private var nameFieldFocused: Bool

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {

                VStack(spacing: 12) {

                    // MARK: Аватар
                    PhotosPicker(selection: $selectedPhoto, matching: .images) {
                        avatarImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 96, height: 96)
                            .clipShape(Circle())
                    }

                    VStack(spacing: 5) {

                        // MARK: Имя + карандаш
                        HStack(spacing: 15) {

                            ZStack {
                                Text(appState.user.username)
                                    .font(.system(size: 18, weight: .semibold))
                                    .opacity(0)

                                if isEditingName {
                                    TextField("", text: $appState.user.username)
                                        .font(.system(size: 18, weight: .semibold))
                                        .multilineTextAlignment(.center)
                                        .focused($nameFieldFocused)
                                        .onSubmit {
                                            finishEditing()
                                        }
                                } else {
                                    Text(appState.user.username)
                                        .font(.system(size: 18, weight: .semibold))
                                }
                            }

                            Button {
                                startEditing()
                            } label: {
                                Image(systemName: "pencil")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                                    .offset(x: -6)
                            }
                        }
                        

                        Text(appState.user.login)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.white)
                .cornerRadius(16)

                VStack(spacing: 0) {

                    NavigationLink {
                        AccountScreen()
                    } label: {
                        ProfileRow(title: "Аккаунт")
                            .foregroundColor(.black)
                    }

                    Divider()

                    NavigationLink {
                        Text("Уведомления")
                    } label: {
                        ProfileRow(title: "Уведомления")
                            .foregroundColor(.black)
                    }

                    Divider()

                    NavigationLink {
                        Text("Настройки")
                    } label: {
                        ProfileRow(title: "Настройки")
                            .foregroundColor(.black)
                    }
                }
                .background(Color.white)
                .cornerRadius(16)

                Button {
                    // logout
                } label: {
                    Text("Выйти из аккаунта")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                }
                .padding(.top, 10)

                Spacer(minLength: 40)
            }
            .padding(.horizontal, 16)
        }
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationTitle("Профиль")
        .onChange(of: selectedPhoto) { newItem in
            loadAvatar(from: newItem)
        }
    }

    private func startEditing() {
        isEditingName = true
        DispatchQueue.main.async {
            nameFieldFocused = true
        }
    }

    private func finishEditing() {
        isEditingName = false
        nameFieldFocused = false
    }

    private func loadAvatar(from item: PhotosPickerItem?) {
        guard let item else { return }

        Task {
            if let data = try? await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                avatarImage = Image(uiImage: uiImage)
            }
        }
    }
}



struct ProfileRow: View {

    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16))

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView()
            
        }
    }
}
