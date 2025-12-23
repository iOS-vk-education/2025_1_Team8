//
//  TestRunView.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 21.12.2025.
//

import SwiftUI

struct TestRunView: View {
    
    @StateObject private var viewModel: TestRunViewModel
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appState: AppState

    init(userId: String, settings: TestSettings) {
        _viewModel = StateObject(
            wrappedValue: TestRunViewModel(
                userId: userId,
                settings: settings
            )
        )
    }

    var body: some View {
        Group {
            if viewModel.isFinished, let attempt = viewModel.attempt {
                TestResultView(attempt: attempt, viewModel: viewModel) {
                    dismiss()
                }
            } else {
                testContent
            }
        }
    }

    
    private var testContent: some View {
        VStack(spacing: 0) {

            header

            Spacer().frame(height: 16)

            progress

            Spacer().frame(height: 24)

            questionCard

            Spacer().frame(height: 24)

            answerSection

            Spacer()

            bottomButtons
        }
        .padding(.horizontal, 20)
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.start()
            appState.user.energy = max(0, appState.user.energy - 1)
        }
    }


    private var header: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .padding(14)
                    .background(Color(.systemGray5))
                    .clipShape(Circle())
            }

            Spacer()

            Text("Тест")
                .font(.system(size: 28, weight: .bold))

            Spacer()

            Color.clear
                .frame(width: 44, height: 44)
        }
    }

    private var progress: some View {
        VStack(spacing: 8) {
            HStack {
                Text(
                    "Вопрос \((viewModel.attempt?.currentIndex ?? 0) + 1) из \(viewModel.attempt?.questionIds.count ?? 0)"
                )
                Spacer()
                Text("Осталось: \(String(format: "%.1f", viewModel.remainingTime))")
            }
            .font(.system(size: 15))
            .foregroundColor(.gray)

            ProgressView(
                value: Double(viewModel.attempt?.currentIndex ?? 0),
                total: Double(viewModel.attempt?.questionIds.count ?? 1)
            )
            .tint(.blue)
        }
    }

    private var questionCard: some View {
        Group {
            if let question = viewModel.question {
                VStack(alignment: .leading, spacing: 16) {

                    Text(question.text)
                        .font(.system(size: 17, weight: .medium))

                    Image(systemName: "lightbulb")
                        .foregroundColor(.gray)
                }
                .padding(16)
                .frame(maxWidth: .infinity) // ⬅️ ВАЖНО
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
                )
            } else {
                Text("Загрузка вопроса...")
            }
        }
    }


    @ViewBuilder
    private var answerSection: some View {
        if let question = viewModel.question {
            switch question.type {
            case .singleChoice:
                singleChoiceOptions(question)
            case .textInput:
                textInput
            }
        }
    }

    private func singleChoiceOptions(_ question: LoadedQuestion) -> some View {
        VStack(spacing: 12) {
            ForEach(question.options) { option in
                Button {
                    viewModel.selectedOptionId = option.id
                } label: {
                    HStack {
                        Text(option.text)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                viewModel.selectedOptionId == option.id
                                ? Color.blue
                                : Color(.systemGray4),
                                lineWidth: 1.5
                            )
                            .background(
                                viewModel.selectedOptionId == option.id
                                ? Color.blue.opacity(0.08)
                                : Color.clear
                            )

                    )
                }
            }
        }
    }

    private var textInput: some View {
        TextField("Введите ответ", text: $viewModel.textAnswer)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(.systemGray4))
            )
    }

    private var bottomButtons: some View {
        HStack(spacing: 12) {

            Button {
                viewModel.skipQuestion()
            } label: {
                StrokeButton(title: "Пропустить вопрос")
                    .frame(height: 52) // ⬅️ выравниваем
            }

            Button {
                viewModel.checkAnswer()
            } label: {
                PrimaryButton(title: "Проверить")
            }
            .disabled(!canCheckAnswer)
        }
        .padding(.bottom, 16)
    }

    private var canCheckAnswer: Bool {
        guard let question = viewModel.question else { return false }

        switch question.type {
        case .singleChoice:
            return viewModel.selectedOptionId != nil
        case .textInput:
            return !viewModel.textAnswer.isEmpty
        }
    }
}
