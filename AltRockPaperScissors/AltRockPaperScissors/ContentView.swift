//
//  ContentView.swift
//  AltRockPaperScissors
//
//  Created by Hank Gay on 7/13/26.
//

import SwiftUI

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

    private var computerMoveIcon: some View {
        Image(systemName: currentComputerMove.iconName())
            .imageScale(.large)
            .foregroundStyle(.tint)
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
                        // TODO: Implement the actual play loop
                    } label: {
                        VStack {
                            Text(Image(systemName: move.iconName()))
                            Text(move.rawValue.capitalized)
                        }.padding()
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
