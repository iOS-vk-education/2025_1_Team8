//
//  HomeView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 04.11.2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 32) {

            Spacer()

            Text("Изучай алгоритмы!")
                .font(.largeTitle)
                .fontWeight(.bold)

            Spacer()

            VStack(spacing: 20) {
                NavigationLink(destination: PlayView()) {
                    PrimaryButton(title: "Играть")
                }

                NavigationLink(destination: TopicsListView()) {
                    PrimaryButton(title: "Изучать алгоритмы")
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Главная")
    }
}

#Preview {
    HomeView()
}
