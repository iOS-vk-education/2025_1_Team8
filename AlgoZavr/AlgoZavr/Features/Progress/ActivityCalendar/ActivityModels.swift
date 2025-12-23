//
//  ActivityModels.swift
//  AlgoZavr
//
//  Created by Татьяна Шевякова on 23.12.2025.
//

import Foundation

struct ProgressAlgorithm: Identifiable, Hashable {
    let id: String
    let title: String
}

struct DayActivityData: Identifiable, Hashable {
    var id: Date { date }
    let date: Date
    let xp: Int
    let learnedAlgorithmsCount: Int
    let algorithms: [ProgressAlgorithm]
}

struct ActivityDay: Identifiable, Equatable {
    var id: Date { date }
    let date: Date
    let activity: DayActivityData?
}
