//
//  ProgressCardView.swift
//  AlgoZavr
//
//  Created by Татьяна Шевякова on 23.12.2025.
//

import SwiftUI

struct ProgressCardView: View {
    var progress: Double
    var learned: Int
    var total: Int

    var body: some View {
        VStack(spacing: 18) {
            Text("Общий прогресс")
                .font(.system(size: 20, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)

            CircularProgressView(progress: progress)
                .frame(width: 160, height: 160)
                .padding(.top, 16)

            Text("Выучено \(learned) алгоритмов из \(total)")
                .font(.system(size: 18))
                .foregroundColor(.gray)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
        )
    }
}

