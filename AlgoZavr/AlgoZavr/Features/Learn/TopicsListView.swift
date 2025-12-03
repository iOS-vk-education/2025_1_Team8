//
//  TopicsListView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 05.11.2025.
//

import SwiftUI

struct TopicsListView: View {
    @StateObject private var viewModel = LearnViewModel()
    
    var body: some View {
        List(viewModel.topics) { topic in
            NavigationLink(destination: AlgorithmDetailView(topic: topic)) {
                Text(topic.title)
            }
        }
        .navigationTitle("Темы")
        .onAppear {
            viewModel.loadTopics()
        }
    }
}

#Preview {
    TopicsListView()
}
