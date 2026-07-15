//
//  ContentView.swift
//  BetterRest
//
//  Created by Hank Gay on 7/15/26.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0

    var body: some View {
        VStack {
            Stepper(
                "Sleep \(sleepAmount.formatted()) hours",
                value: $sleepAmount,
                in: 4...12,
                step: 0.25,
            )
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
