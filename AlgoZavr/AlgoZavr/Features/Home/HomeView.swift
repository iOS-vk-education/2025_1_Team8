//
//  HomeView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 04.11.2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                
                Spacer()
                
                VStack(spacing: 8) {
                    Text("Изучай алгоритмы!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }

                Spacer()
                
                VStack(spacing: 20) {
                    NavigationLink {
                        Text("PlayView")
                            .font(.title2)
                            .navigationTitle("Играть")
                    } label: {
                        PrimaryButton(title: "Играть")
                    }

                    NavigationLink {
                        TopicsListView()
                    } label: {
                        PrimaryButton(title: "Изучать алгоритмы")
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Главная")
        }
    }
}

#Preview {
    HomeView()
}

