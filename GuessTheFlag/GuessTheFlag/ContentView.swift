//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Hank Gay on 7/3/26.
//

import SwiftUI

struct ContentView: View {
   let countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    var correctAnswer = Int.random(in: 0...2)

    @State private var showingAlert = false

    var body: some View {
        VStack(spacing: 30) {
            VStack {
                Text("Tap the flag of")
                Text(countries[correctAnswer])
            }
            ForEach(0..<3) { number in
                Button {
                    // flag was tapped
                } label: {
                    Image(countries[number].lowercased())
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
