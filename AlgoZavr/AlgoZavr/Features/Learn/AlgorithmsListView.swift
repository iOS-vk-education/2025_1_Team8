//
//  AlgorithmsListView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 22.12.2025.
//

import SwiftUI

struct AlgorithmsListView: View {
    
    let topic: Topic
    
    var body: some View {
        List(topic.algorithms) { algorithm in
            NavigationLink(destination: AlgorithmDetailView(algorithm: algorithm)) {
                Text(algorithm.title)
            }
        }
        .navigationTitle(topic.title)
    }
}
