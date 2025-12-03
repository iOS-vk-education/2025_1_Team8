//
//  PrimaryButton.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 04.11.2025.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.system(size: 23, weight: .semibold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 18)
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
