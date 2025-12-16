//
//  ProgressScreen.swift
//  AlgoZavr
//
//  Created by Татьяна Шевякова on 09.12.2025.
//

import SwiftUI

struct ProgressScreen: View {
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .leading, spacing: 20) {
            
                ProgressCardView(progress: (27.0 / 74.0), learned: 27, total: 74)
                
                ActivityCardView(
                    streak: 153,
                    today: 12,
                    selectedDay: 12,
                    days: [
                        1: true, 2: false, 3: false, 4: true, 5: true,
                        6: true, 7: true, 8: false,9: true, 10: true,
                        11: true, 12: true, 13: false, 14: false, 15: false
                    ]
                )
                
                Spacer(minLength: 40)
            }
            .padding(.horizontal, 16)
        }
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationTitle("Прогресс")
    }
}


struct ProgressCardView: View {
    var progress: Double
    var learned: Int
    var total: Int

    var body: some View {
        VStack(spacing: 18) {
            
            Text("Общий прогресс")
                .font(.system(size: 20, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            CircularProgressView(progress: progress)
                .frame(width: 160, height: 160)
                .padding(.top, 16)
            
            Text("Выучено \(learned) алгоритмов из \(total)")
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(.gray)
                .padding(.top, 15)
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 15)
        .padding(.bottom, 30)
        .padding(.top, 15)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
        )
    }
}

struct CircularProgressView: View {
    var progress: Double

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

            Text("\(Int(progress * 100))%")
                .font(.system(size: 26, weight: .bold))
        }
        .frame(width: 160, height: 160)
    }
}

struct DayCarouselView: View {
    let days: [Int: Bool]
    let today: Int
    @Binding var selectedDay: Int

    @State private var currentIndex: Int = 0

    var sortedDays: [Int] {
        days.keys.sorted()
    }

    var body: some View {
        ScrollViewReader { proxy in
            HStack(spacing: 5) {
                
                Button {
                    withAnimation(.easeInOut) {
                        if currentIndex > 0 {
                            currentIndex -= 1
                            let targetDay = sortedDays[currentIndex]
                            selectedDay = targetDay
                            proxy.scrollTo(targetDay, anchor: .center)
                        }
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.gray)
                        .font(.system(size: 18))
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(sortedDays, id: \.self) { day in
                            Button {
                                withAnimation(.spring()) {
                                    selectedDay = day
                                    if let idx = sortedDays.firstIndex(of: day) {
                                        currentIndex = idx
                                        proxy.scrollTo(day, anchor: .center)
                                    }
                                }
                            } label: {
                                ActivityDayCircle(
                                    day: day,
                                    isActive: days[day] ?? false,
                                    isSelected: day == selectedDay,
                                    isToday: day == today
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .frame(maxWidth: .infinity)

                Button {
                    withAnimation(.easeInOut) {
                        if currentIndex < sortedDays.count - 1 {
                            currentIndex += 1
                            let targetDay = sortedDays[currentIndex]
                            selectedDay = targetDay
                            proxy.scrollTo(targetDay, anchor: .center)
                        }
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                        .font(.system(size: 18))
                }
            }
            .onAppear {
                // ставим "сегодня" по центру при первом показе
                if let todayIndex = sortedDays.firstIndex(of: today) {
                    currentIndex = todayIndex
                    if selectedDay == 0 {
                        selectedDay = today
                    }
                    DispatchQueue.main.async {
                        withAnimation {
                            proxy.scrollTo(today, anchor: .center)
                        }
                    }
                }
            }
        }
    }
}


struct ActivityCardView: View {
    var streak: Int
    var today: Int
    @State var selectedDay: Int
    var days: [Int: Bool]

    let baseMonth = 11
    let baseYear = 2024

    var currentMonth: String {
        var components = DateComponents()
        components.year = baseYear
        components.month = baseMonth
        components.day = selectedDay

        let calendar = Calendar.current
        let date = calendar.date(from: components) ?? Date()

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "LLLL"

        return formatter.string(from: date).capitalized
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 25) {

            VStack(alignment: .leading, spacing: 5) {
                Text("Активность")
                    .font(.system(size: 20, weight: .bold))
                
                Text("\(streak) дня 🔥")
                    .font(.system(size: 18, weight: .medium))
            }

            VStack(alignment: .leading, spacing: 5) {

                Text(currentMonth)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .center)

                DayCarouselView(
                    days: days,
                    today: today,
                    selectedDay: $selectedDay
                )
            }

            VStack(alignment: .leading, spacing: 15) {
                Text("Активность за день")
                    .font(.system(size: 19, weight: .semibold))

                VStack(alignment: .leading, spacing: 5) {
                    Text("Получено опыта: ")
                        .font(.system(size: 18, weight: .regular))
                    +
                    Text("80 XP")
                        .font(.system(size: 18, weight: .medium))

                    DisclosureGroup("Изучено 3 алгоритма") {
                        VStack(alignment: .leading, spacing: 5) {
                            ForEach(0..<3) { i in
                                Text("\(i + 1). Алгоритм \(i)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.system(size: 16, weight: .regular))
                            }
                        }
                        .padding(.top, 5)
                    }
                    .foregroundStyle(Color.black)
                    .font(.system(size: 18, weight: .medium))
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.bottom, 30)
        .padding(.top, 15)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
        )
    }
}


struct ActivityDayCircle: View {
    let day: Int
    let isActive: Bool
    let isSelected: Bool
    let isToday: Bool

    var body: some View {
        let currentColor: Color = isActive ? Color(hex: "81D57D") : Color(hex: "C7C7CC")
        ZStack {
            Circle()
                .fill(currentColor)
                .frame(width: isSelected ? 40 : 38, height: isSelected ? 40 : 38)
                .overlay(
                    Circle()
                        .strokeBorder(
                            isToday ? Color(hex: "5BC55A") : .clear,
                            lineWidth: isToday ? 3 : 0
                        )
                )
                .shadow(
                    color: isSelected ? Color.blue.opacity(0.7) : .clear,
                    radius: isSelected ? 5 : 0
                )

            Text("\(day)")
                .foregroundColor(.white)
                .font(.system(size: 15, weight: .semibold))
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}



struct ProgressScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProgressScreen()
        }
    }
}

