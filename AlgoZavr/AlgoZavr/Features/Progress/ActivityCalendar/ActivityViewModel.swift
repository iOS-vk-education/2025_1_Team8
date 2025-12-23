//
//  ActivityViewModel.swift
//  AlgoZavr
//
//  Created by Татьяна Шевякова on 23.12.2025.
//

import Foundation
internal import Combine


final class ActivityViewModel: ObservableObject {

    @Published var selectedDate: Date = Date()
    @Published var currentMonth: Date = Date()
    @Published var days: [ActivityDay] = []

    private let calendar = Calendar.current
    private var activitiesByDay: [Date: DayActivityData] = [:]

    init() {}

    func load(activities: [DayActivityData]) {
        activitiesByDay = Dictionary(
            uniqueKeysWithValues: activities.map {
                (calendar.startOfDay(for: $0.date), $0)
            }
        )
        resetToToday()
        rebuildDays()
    }


    func resetToToday() {
        selectedDate = Date()
        currentMonth = Date()
    }

    func rebuildDays() {
        let range = calendar.range(of: .day, in: .month, for: currentMonth)!

        days = range.compactMap { day in
            var components = calendar.dateComponents([.year, .month], from: currentMonth)
            components.day = day
            guard let date = calendar.date(from: components) else { return nil }

            let normalized = calendar.startOfDay(for: date)
            return ActivityDay(
                date: date,
                activity: activitiesByDay[normalized]
            )
        }
    }

    func selectDay(_ date: Date) {
        selectedDate = date

        if !calendar.isDate(date, equalTo: currentMonth, toGranularity: .month) {
            currentMonth = date
            rebuildDays()
        }
    }

    func previousMonth() {
        currentMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth)!
        rebuildDays()
    }

    func nextMonth() {
        currentMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth)!
        rebuildDays()
    }

    func isSelected(_ date: Date) -> Bool {
        calendar.isDate(date, inSameDayAs: selectedDate)
    }

    var selectedDayActivity: DayActivityData? {
        activitiesByDay[calendar.startOfDay(for: selectedDate)]
    }

    var monthTitle: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: currentMonth).capitalized
    }
}

