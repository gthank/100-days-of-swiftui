//
//  ContentView.swift
//  iExpense
//
//  Created by Hank Gay on 8/19/26.
//

import SwiftUI
import Observation

struct ContentView: View {
    @State private var showingSecondSheet = false

    var body: some View {
        Button("Show Sheet") {
            showingSecondSheet.toggle()
        }.sheet(isPresented: $showingSecondSheet) {
            SecondView(name: "Baggins. Bilbo Baggins.")
        }
    }
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss

    let name: String

    var body: some View {
        Text("Hello, \(name)!")
        Button("Dismiss") {
            dismiss()
        }
    }
}

#Preview {
    ContentView()
}
