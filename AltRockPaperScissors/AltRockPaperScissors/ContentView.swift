//
//  ContentView.swift
//  AltRockPaperScissors
//
//  Created by Hank Gay on 7/13/26.
//

import SwiftUI

enum Result {
    case computerWin
    case humanWin
    case tie
}

enum ValidMove : String, CaseIterable {
    case rock
    case paper
    case scissors

    static func randomMove() -> ValidMove {
        ValidMove.allCases.randomElement()!
    }

    func iconName() -> String {
        return switch self {
        case .rock:
            "mountain.2"
        case .paper:
            "doc"
        case .scissors:
            "scissors"
        }
    }
}

func toDict<T, K: Hashable, V>(
    from array: Array<T>,
    mapper: (T) -> (key: K, value: V),
) -> Dictionary<K, V> {
    var dict = [K: V]()
    for element in array {
        let (key, value) = mapper(element)
        dict[key] = value
    }
    return dict
}

struct ContentView: View {
    @State private var currentComputerMove = ValidMove.randomMove()
    @State private var doesPlayerWantToWin = true
    @State private var score = 0

    private var computerMoveIcon: some View {
        Image(systemName: currentComputerMove.iconName())
            .imageScale(.large)
            .foregroundStyle(.tint)
    }

    func judgeMove(computerMove: ValidMove, humanMove: ValidMove) -> Result {
        return switch (computerMove, humanMove) {
        case (.rock, .rock):
            .tie
        case (.rock, .paper):
            .humanWin
        case (.rock, .scissors):
            .computerWin
        case (.paper, .rock):
            .computerWin
        case (.paper, .paper):
            .tie
        case (.paper, .scissors):
            .humanWin
        case (.scissors, .rock):
            .humanWin
        case (.scissors, .paper):
            .computerWin
        case (.scissors, .scissors):
            .tie
        }
    }

    func updateScore(result: Result) {
        switch result {
        case .tie:
            // no-op
            print("Nothing to see here. Move along!")
        case .computerWin:
            if doesPlayerWantToWin {
                score -= 1
            } else {
                score += 1
            }
        case .humanWin:
            if doesPlayerWantToWin {
                score += 1
            } else {
                score -= 1
            }
        }
    }

    func nextMove() {
        currentComputerMove = ValidMove.randomMove()
        doesPlayerWantToWin = Bool.random()
    }

    func handlePlayerMove(_ humanMove: ValidMove) {
        print("Hallo hallo hallo! \(humanMove)")
        let result = judgeMove(computerMove: currentComputerMove, humanMove: humanMove)
        updateScore(result: result)
        nextMove()
    }

    var body: some View {
        VStack {
            Spacer()
            Text("Computer Played").font(.largeTitle)
            computerMoveIcon
            Spacer()
            Text("Your mission, should you choose to accept it, is to \(doesPlayerWantToWin ? "WIN" : "LOSE")").padding()
            HStack {
                ForEach(ValidMove.allCases, id: \.self) { move in
                    Button {
                        handlePlayerMove(move)
                    } label: {
                        VStack {
                            Image(systemName: move.iconName()).imageScale(.large)
                            Text(move.rawValue.capitalized)
                        }.padding()
                    }
                }
            }
            Spacer()
            HStack {
                Text("Score").font(.headline)
                Text("\(score)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
