//
//  ActivityCalendarView.swift
//  AlgoZavr
//
//  Created by Татьяна Шевякова on 23.12.2025.
//

import SwiftUI

struct ActivityCalendarView: View {

    @StateObject private var viewModel = ActivityViewModel()

    var body: some View {
        VStack(spacing: 16) {

            HStack {
                Button { viewModel.previousMonth() } label: {
                    Image(systemName: "chevron.left")
                }

                Spacer()

                Text(viewModel.monthTitle)
                    .font(.system(size: 18, weight: .semibold))

                Spacer()

                Button { viewModel.nextMonth() } label: {
                    Image(systemName: "chevron.right")
                }
            }

            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.days) { day in
                            Text(dayNumber(from: day.date))
                                .font(.system(size: 16, weight: .semibold))
                                .frame(width: 48, height: 48)
                                .background(
                                    Circle()
                                        .fill(
                                            day.activity != nil
                                            ? Color(red: 145/255, green: 220/255, blue: 140/255)
                                            : Color.gray.opacity(0.3)
                                        )
                                )
                                .overlay(
                                    Circle()
                                        .inset(by: 1)
                                        .stroke(
                                            viewModel.isSelected(day.date) ? Color.blue : Color.clear,
                                            lineWidth: 2
                                        )
                                )
                                .foregroundColor(.black)
                                .id(day.id)
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.selectDay(day.date)
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                .onChange(of: viewModel.days) { _ in
                    withAnimation {
                        proxy.scrollTo(viewModel.selectedDate, anchor: .center)
                    }
                }
                .onChange(of: viewModel.selectedDate) { newDate in
                    withAnimation {
                        proxy.scrollTo(newDate, anchor: .center)
                    }
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Активность за день")
                    .font(.system(size: 18, weight: .semibold))

                if let activity = viewModel.selectedDayActivity {
                    Text("Опыт: \(activity.xp) XP")
                    Text("Алгоритмов: \(activity.learnedAlgorithmsCount)")

                    ForEach(activity.algorithms) { algo in
                        Text("• \(algo.title)")
                            .foregroundColor(.secondary)
                    }
                } else {
                    Text("В этот день активности не было")
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
        }
        .padding()
    }

    private func dayNumber(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
}

