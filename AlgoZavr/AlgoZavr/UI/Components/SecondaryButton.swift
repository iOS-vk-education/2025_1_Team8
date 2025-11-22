//
//  SecondaryButton.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 19.11.2025.
//

import SwiftUI

struct SecondaryButton: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.system(size: 23, weight: .semibold))
            .foregroundColor(.blue)
            .underline()
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
    }
}
