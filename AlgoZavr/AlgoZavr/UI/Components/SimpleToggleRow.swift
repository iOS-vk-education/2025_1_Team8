//
//  SimpleToggleRow.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 22.12.2025.
//

import SwiftUI

struct SimpleToggleRow: View {
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 17))

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
        .padding(.horizontal, 16)
        .frame(height: 52)
    }
}
