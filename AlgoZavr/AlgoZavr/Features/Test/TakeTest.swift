//
//  TakeTest.swift
//  AlgoZavr
//
//  Created by Татьяна Шевякова on 08.12.2025.
//

import SwiftUI

struct TakeTest: View {

    @State private var questionCount: Int = 10
    @State private var selectedDifficulty: String = "Нормальная"
    @State private var selectedAlgorithms: String = "Изученные"
    @State private var timerEnabled: Bool = false

    @State private var topics: [String: Bool] = [
        "Сортировки": false,
        "Поиски": false,
        "Структуры данных": false,
        "Графы": false,
        "Кратчайшие пути": false,
        "Остовные деревья": false,
        "Динамическое программирование": false,
        "Строки": false,
        "Теория чисел": false,
        "Геометрия": false,
        "Жадные алгоритмы": false
    ]

    let topicOrder = [
        "Сортировки",
        "Поиски",
        "Структуры данных",
        "Графы",
        "Кратчайшие пути",
        "Остовные деревья",
        "Динамическое программирование",
        "Строки",
        "Теория чисел",
        "Геометрия",
        "Жадные алгоритмы"
    ]

    let difficulties = ["Легкая", "Нормальная", "Сложная"]
    let algorithmTypes = ["Все", "Изученные", "Неизученные"]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 28) {

                // MARK: Настройки теста
                VStack(spacing: 0) {

                    SimpleRow(title: "Количество заданий") {
                        Picker("", selection: $questionCount) {
                            ForEach([5, 10, 15, 20, 25, 30], id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.menu)
                    }

                    Divider()

                    SimpleRow(title: "Сложность") {
                        Picker("", selection: $selectedDifficulty) {
                            ForEach(difficulties, id: \.self, content: Text.init)
                        }
                        .pickerStyle(.menu)
                    }

                    Divider()

                    SimpleRow(title: "Алгоритмы") {
                        Picker("", selection: $selectedAlgorithms) {
                            ForEach(algorithmTypes, id: \.self, content: Text.init)
                        }
                        .pickerStyle(.menu)
                    }

                    Divider()

                    SimpleToggleRow(title: "Таймер", isOn: $timerEnabled)
                }
                .background(RoundedRectangle(cornerRadius: 16).fill(.white))
                .padding(.horizontal, 16)

                NavigationLink {
                    QuickTest()
                } label: {
                    PrimaryButton(title: "Начать", icon: "bolt.fill")
                }
                .padding(.horizontal)

                // MARK: Темы
                VStack(alignment: .leading, spacing: 16) {

                    HStack {
                        Text("Выбрать темы")
                            .font(.system(size: 22, weight: .bold))

                        Spacer()

                        Button("Выбрать все") {
                            topicOrder.forEach { topics[$0] = true }
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.blue)
                    }
                    .padding(.horizontal)

                    VStack(spacing: 0) {
                        ForEach(topicOrder.indices, id: \.self) { index in
                            let topic = topicOrder[index]

                            HStack {
                                Text(topic)
                                    .font(.system(size: 17))

                                Spacer()

                                Toggle("", isOn: Binding(
                                    get: { topics[topic] ?? false },
                                    set: { topics[topic] = $0 }
                                ))
                                .labelsHidden()
                            }
                            .padding(.horizontal, 16)
                            .frame(height: 52)

                            if index != topicOrder.indices.last {
                                Divider()
                            }
                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 16).fill(.white))
                    .padding(.horizontal)

                    Button("Очистить выбор") {
                        topicOrder.forEach { topics[$0] = false }
                    }
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
                }

                Spacer(minLength: 40)
            }
        }
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationTitle("Пройти тест")
    }
}


struct SimpleRow<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 17))

            Spacer()

            content
                .labelsHidden()
        }
        .padding(.horizontal, 16)
        .frame(height: 52)
        .contentShape(Rectangle())
    }
}

struct SimpleToggleRow: View {
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 17))

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
        .padding(.horizontal, 16)
        .frame(height: 52)
    }
}

struct TakeTest_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TakeTest()
        }
    }
}
