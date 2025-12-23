//
//  TakeTest.swift
//  AlgoZavr
//
//  Created by Татьяна Шевякова on 08.12.2025.
//

import SwiftUI
import FirebaseAuth

struct TakeTest: View {
    
    @EnvironmentObject private var appState: AppState

    @StateObject private var learnViewModel = LearnViewModel()
    @StateObject private var viewModel = TakeTestViewModel()

    @State private var startTest = false
    @State private var settingsForTest: TestSettings?

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 28) {

                VStack(spacing: 0) {

                    SimpleRow(title: "Количество заданий") {
                        Picker("", selection: $viewModel.questionCount) {
                            ForEach([5, 10, 15, 20, 25, 30], id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    Divider()

                    SimpleRow(title: "Сложность") {
                        Picker("", selection: $viewModel.selectedDifficulty) {
                            ForEach(viewModel.difficulties, id: \.self, content: Text.init)
                        }
                        .pickerStyle(.menu)
                    }

                    Divider()

                    SimpleRow(title: "Алгоритмы") {
                        Picker("", selection: $viewModel.selectedAlgorithms) {
                            ForEach(viewModel.algorithmTypes, id: \.self, content: Text.init)
                        }
                        .pickerStyle(.menu)
                    }

                    Divider()

                    SimpleToggleRow(title: "Таймер", isOn: $viewModel.timerEnabled)
                }
                .background(RoundedRectangle(cornerRadius: 16).fill(.white))
                .padding(.horizontal, 16)

                Button {
                    let settings = viewModel.makeSettings()
                    appState.homePath.append(HomeRoute.testRun(settings))
                } label: {
                    PrimaryButton(title: "Начать", icon: "bolt.fill")
                }
                .padding(.horizontal)
                .disabled(!viewModel.canStartTest)
                .opacity(viewModel.canStartTest ? 1 : 0.55)


                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Выбрать темы")
                            .font(.system(size: 22, weight: .bold))

                        Spacer()

                        Button("Выбрать все") {
                            viewModel.selectAllTopics()
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.blue)
                    }
                    .padding(.horizontal)

                    VStack(spacing: 0) {
                        ForEach(viewModel.topicOrder.indices, id: \.self) { index in
                            let topicId = viewModel.topicOrder[index]
                            let title = learnViewModel.topics.first { $0.id == topicId }?.title ?? ""

                            HStack {
                                Text(title)
                                    .font(.system(size: 17))

                                Spacer()

                                Toggle(
                                    "",
                                    isOn: Binding(
                                        get: { viewModel.topicsSelection[topicId] ?? false },
                                        set: { viewModel.topicsSelection[topicId] = $0 }
                                    )
                                )
                                .labelsHidden()
                            }
                            .padding(.horizontal, 16)
                            .frame(height: 52)
                            if index != viewModel.topicOrder.indices.last {
                                        Divider()
                                    }
                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 16).fill(.white))
                    .padding(.horizontal)

                    Button("Очистить выбор") {
                        viewModel.clearTopicsSelection()
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

        .onAppear {
            learnViewModel.loadTopics()
        }
        .onReceive(learnViewModel.$topics) { topics in
            viewModel.updateTopics(topics)
        }
    }
}
