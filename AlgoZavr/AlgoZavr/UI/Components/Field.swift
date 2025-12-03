//
//  Field.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 19.11.2025.
//

import SwiftUI

struct GlassField: View {
    @Binding var text: String
    let placeholder: String
    var isSecure: Bool = false

    @FocusState private var isFocused: Bool
    @State private var isPasswordVisible = false

    var body: some View {
        ZStack(alignment: .leading) {
            
            if text.isEmpty && !isFocused {
                Text(placeholder)
                    .foregroundColor(Color.black.opacity(0.4))
                    .padding(.horizontal, 16)
            }

            HStack {
                
                Group {
                    if isSecure && !isPasswordVisible {
                        SecureField("", text: $text)
                    } else {
                        TextField("", text: $text)
                    }
                }
                .focused($isFocused)
                .padding(.leading, 16)
                
                if isSecure {
                    Button {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            isPasswordVisible.toggle()
                        }
                    } label: {
                        Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                            .foregroundColor(Color.black.opacity(0.4))
                    }
                    .padding(.trailing, 12)
                } else {
                    Color.clear
                        .frame(width: 24)
                        .padding(.trailing, 12)
                }
            }
        }
        .frame(height: 44)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.gray.opacity(0.15))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.black.opacity(0.1))
        )
        .shadow(color: .black.opacity(0.05), radius: 3)
    }
}
