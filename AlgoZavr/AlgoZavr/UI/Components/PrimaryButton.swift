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
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}
