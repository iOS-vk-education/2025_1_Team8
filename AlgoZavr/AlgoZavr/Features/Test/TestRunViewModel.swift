//
//  TestRunViewModel.swift
//  AlgoZavr
//
//  Created by Никита Поскрёбышев on 22.12.2025.
//


import Foundation
import FirebaseFirestore
internal import Combine
import SwiftUI

@MainActor
final class TestRunViewModel: ObservableObject {

    @Published private(set) var attempt: TestAttempt?
    @Published private(set) var question: LoadedQuestion?
    @Published var selectedOptionId: String? = nil
    @Published var textAnswer: String = ""
    @Published var isFinished: Bool = false

    @Published var remainingTime: Double = 15.0

    private let userId: String
    private let settings: TestSettings

    private let generator: TestGenerationService = TestGenerationServiceFirestore()
    private let db = Firestore.firestore()
    private var timer: Timer?

    init(userId: String, settings: TestSettings) {
        self.userId = userId
        self.settings = settings
    }

    func start() {
        Task {
            do {
                self.attempt = try await generator.createTest(
                    userId: userId,
                    settings: settings
                )
                try await loadCurrentQuestion()

            } catch {
                print("Failed to start test:", error)
            }
        }
    }

    private func loadCurrentQuestion() async throws {
        guard let attempt else { return }

        let index = attempt.currentIndex
        guard index < attempt.questionIds.count else {
            isFinished = true
            stopTimer()
            return
        }

        let qid = attempt.questionIds[index]
        let snap = try await db.collection("questions").document(qid).getDocument()
        let data = snap.data() ?? [:]

        let text = data["text"] as? String ?? ""

        let rawOptions = data["answers"] as? [[String: Any]] ?? []

        let options: [LoadedQuestion.Option] = rawOptions.compactMap { option in
            guard
                let text = option["text"] as? String,
                let isCorrect = option["isCorrect"] as? Bool
            else { return nil }

            return LoadedQuestion.Option(
                id: UUID().uuidString,
                text: text,
                isCorrect: isCorrect
            )
        }



        let type: QuestionType = options.isEmpty ? .textInput : .singleChoice

        question = LoadedQuestion(
            id: qid,
            text: text,
            type: type,
            options: options
        )

        selectedOptionId = nil
        textAnswer = ""
        resetTimerValue()
        startTimerIfNeeded()
    }

    func skipQuestion() {
        Task { await goNextQuestion() }
    }

    func checkAnswer() {
        guard let question else { return }

        var isCorrect = false

        switch question.type {
        case .singleChoice:
            if let selectedId = selectedOptionId,
               let option = question.options.first(where: { $0.id == selectedId }) {
                isCorrect = option.isCorrect
            }

        case .textInput:
            isCorrect = false
        }

        if isCorrect {
            attempt?.scoreCorrect += 1
        }

        Task { await goNextQuestion() }
    }


    private func goNextQuestion() async {
        guard var attempt else { return }

        let next = attempt.currentIndex + 1
        self.attempt?.currentIndex = next
        try? await loadCurrentQuestion()
    }

    private func startTimerIfNeeded() {
        guard settings.timerEnabled else { return }

        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] t in
            guard let self else { return }
            Task { @MainActor in
                if self.remainingTime > 0 {
                    self.remainingTime -= 0.1
                } else {
                    t.invalidate()
                    await self.goNextQuestion()
                }
            }
        }
    }
    
    func saveResultAndAddXP(XP: Int) async throws {
        guard let attempt else { return }

        let userRef = db.collection("users").document(userId)

        let attemptRef = userRef
            .collection("testAttempts")
            .document(attempt.id)

        try await attemptRef.updateData([
            "scoreCorrect": attempt.scoreCorrect,
        ])

        try await userRef.updateData([
            "XP": FieldValue.increment(Int64(XP))
        ])
    }


    private func resetTimerValue() {
        remainingTime = 15.0
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
