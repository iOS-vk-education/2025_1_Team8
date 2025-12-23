//
//  StrokeButton.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 22.12.2025.
//

import SwiftUI

struct StrokeButton: View {
    let title: String
    var icon: String? = nil

    var body: some View {
        HStack(spacing: 8) {
            if let icon {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black.opacity(0.6))
            }

            Text(title)
                .font(.system(size: 18, weight: .medium))
        }
        .foregroundColor(.black)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(.systemGray5))
        )
    }
}
