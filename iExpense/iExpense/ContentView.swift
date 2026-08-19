//
//  ContentView.swift
//  iExpense
//
//  Created by Hank Gay on 8/19/26.
//

import SwiftUI
import Observation

struct ContentView: View {
    @AppStorage("tapCount") private var tapCount = 0

    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
        }
    }
}

#Preview {
    ContentView()
}
