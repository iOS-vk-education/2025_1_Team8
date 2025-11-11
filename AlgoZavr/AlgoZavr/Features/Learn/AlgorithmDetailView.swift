//
//  AlgorithmDetailView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 05.11.2025.
//

import SwiftUI

struct AlgorithmDetailView: View {
    let topic: Topic
    
    var body: some View {
        List(topic.algorithms, id: \.self) { algo in
            NavigationLink(algo, destination: Text(algo))
        }
        .navigationTitle(topic.title)
    }
}
