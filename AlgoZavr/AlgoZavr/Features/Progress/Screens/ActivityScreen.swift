//
//  ActivityScreen.swift
//  AlgoZavr
//
//  Created by Татьяна Шевякова on 23.12.2025.
//

import SwiftUI

struct ActivityScreen: View {

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                Text("Активность")
                    .font(.system(size: 22, weight: .bold))

                ActivityCalendarView()
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.white)
            )
        }
    }
}

