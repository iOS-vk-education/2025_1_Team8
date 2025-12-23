//
//  SimpleRow.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 22.12.2025.
//

import SwiftUI

struct SimpleRow<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 17))

            Spacer()

            content
                .labelsHidden()
        }
        .padding(.horizontal, 16)
        .frame(height: 52)
        .contentShape(Rectangle())
    }
}
