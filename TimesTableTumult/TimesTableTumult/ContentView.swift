//
//  ContentView.swift
//  TimesTableTumult
//
//  Created by Hank Gay on 8/9/26.
//

import SwiftUI

let validMultiplicands = 2...12

struct ContentView: View {
    @State private var numQuestionsToAsk = 5
    @State private var isInSetupMode = true
    @State private var multiplicand = Int.random(in: validMultiplicands)

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Stepper(value: $multiplicand, in: validMultiplicands) {
                        Text("Times Table for \(multiplicand)").monospacedDigit()
                    }.accessibilityLabel("Practice Times Table for \(multiplicand)")
                    Picker("Number of Questions", selection: $numQuestionsToAsk) {
                        ForEach([5, 10, 20], id: \.self) {
                            Text("\($0)")
                        }
                    }
                }

                NavigationLink("Practice") {
                    PracticeScreen(
                        multiplicand: multiplicand,
                        numQuestions: numQuestionsToAsk,
                    )
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding()
            }
            .navigationTitle("Times Tables Tumult!")
        }.padding()
    }
}

struct PracticeScreen: View {
    struct QandA {
        let question: String
        let answer: Int

        init(multiplier: Int, multiplicand: Int) {
            self.question = "What is \(multiplier) times \(multiplicand)?"
            self.answer = multiplier * multiplicand
        }
    }

    private var multiplicand = 2
    private var numQuestions = 5
    @State private var questionsAndAnswers: [QandA] = []
    @State private var userAnswer: Int?
    @State private var currentQandA: QandA?

    init(multiplicand: Int, numQuestions: Int) {
        self.multiplicand = multiplicand
        self.numQuestions = numQuestions
    }

    func setupGame() {
        questionsAndAnswers.removeAll()

        let multipliers = validMultiplicands.shuffled().prefix(numQuestions)
        for multiplier in multipliers {
            self.questionsAndAnswers.append(
                QandA(multiplier: multiplier, multiplicand: multiplicand)
            )
        }

        askQuestion()
    }

    func askQuestion() {
        // Pop question from front of queue.
        guard !questionsAndAnswers.isEmpty else { return }
        currentQandA = questionsAndAnswers.removeFirst()
        userAnswer = nil
    }

    func handleAnswer() {
        if let current = currentQandA {
            // If correct, tell the user.
            if userAnswer == current.answer {
                // TODO: Use actual user-visible messaging.
                print("Huzzah!")
            } else {
                // TODO: Use actual user-visible messaging.
                print("Well 💩")
                questionsAndAnswers.append(current)
            }
            askQuestion()
        }
    }

    var body: some View {
        Form {
            Text("We Talkin' 'bout Practice!")
                .font(.headline)
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()

            if let currentQandA = currentQandA {
                Section(header: Text("Problem")) {
                    HStack {
                        Text(currentQandA.question)

                        TextField(
                            "Your Answer",
                            value: $userAnswer,
                            format: .number,
                        ).keyboardType(.numberPad)
                    }

                    Button("Submit") {
                        handleAnswer()
                    }
                    .disabled(userAnswer == nil)
                }
            } else {
                Text("Congrats!").font(.headline)
            }
        }
        .navigationTitle("Practicing Our \(multiplicand)s")
        .onAppear(perform: setupGame)
    }
}

struct SettingsScreen: View {
    var body: some View {
        Text("Under Construction!")
    }
}

#Preview {
    ContentView()
}
