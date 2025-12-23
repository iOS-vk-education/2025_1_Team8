//
//  TestResultCircularView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 23.12.2025.
//

import SwiftUI

struct TestResultCircularView: View {
    let correct: Int
    let total: Int

    var progress: Double {
        total == 0 ? 0 : Double(correct) / Double(total)
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.blue.opacity(0.18), lineWidth: 23)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.blue,
                    style: StrokeStyle(lineWidth: 18, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))

            Text("\(correct)/\(total)")
                .font(.system(size: 28, weight: .bold))
        }
        .frame(width: 160, height: 160)
    }
}
