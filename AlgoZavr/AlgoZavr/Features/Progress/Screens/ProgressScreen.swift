//
//  ProgressScreen.swift
//  AlgoZavr
//
//  Created by Татьяна Шевякова on 23.12.2025.
//

import SwiftUI

struct ProgressScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                ProgressCardView(progress: (27.0 / 74.0), learned: 27, total: 74)
                ActivityScreen()
                Spacer(minLength: 40)
            }
            .padding(.horizontal, 16)
        }
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationTitle("Прогресс")
    }
}

#Preview {
    NavigationStack {
        ProgressScreen()
    }
}
