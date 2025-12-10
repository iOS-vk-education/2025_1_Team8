//
//  PrimaryButton.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 04.11.2025.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var icon: String? = nil

    var body: some View {
        HStack(spacing: 8) {

            if let icon {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.yellow)
            }

            Text(title)
                .font(.system(size: 20, weight: .medium))
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.blue)
        )
        .shadow(
            color: Color.black.opacity(0.25),
            radius: 12,
            x: 0,
            y: 4
        )
    }
}
