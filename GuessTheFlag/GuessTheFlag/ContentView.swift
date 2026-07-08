//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Hank Gay on 7/3/26.
//

import SwiftUI

struct ContentView: View {
    let questionsPerGame = 8
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var numQuestionsSoFar = 0

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }

    func startNewGame() {
        score = 0
        numQuestionsSoFar = 0
        askQuestion()
    }

    func flagTapped(_ number: Int) {
        numQuestionsSoFar += 1
        if number == correctAnswer {
            scoreTitle = "Correct-a-mundo, buuuuu-ddy!"
            score += 200
        } else {
            scoreTitle = "BZZZT! Wrong! That's the flag of \(countries[number])"
            score -= 100
        }
        showingScore = true
    }

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of").foregroundStyle(.secondary).font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer]).font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number].lowercased()).clipShape(.capsule).shadow(radius: 5)
                        }
                    }
                }
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 20))
        .alert(scoreTitle, isPresented: $showingScore) {
            if numQuestionsSoFar >= 8 {
                Button("Play Again", action: startNewGame)
            } else {
                Button("Continue", action: askQuestion)
            }
        } message: {
            Text("Your score is \(score)")
        }
    }
}

#Preview {
    ContentView()
}
