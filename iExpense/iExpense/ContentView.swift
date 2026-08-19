//
//  ContentView.swift
//  iExpense
//
//  Created by Hank Gay on 8/19/26.
//

import SwiftUI
import Observation

struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }.onDelete(perform: removeRows)
                }

                Button("Add a number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .toolbar {
                EditButton()
            }
        }
    }
}

#Preview {
    ContentView()
}
