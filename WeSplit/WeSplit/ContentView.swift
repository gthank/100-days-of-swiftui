//
//  ContentView.swift
//  WeSplit
//
//  Created by Hank Gay on 6/29/26.
//

import SwiftUI

struct ContentView: View {
    private let validTipPercentages = [2, 15, 18, 20, 25]
    let currencyIdentifier = Locale.current.currency?.identifier ?? "USD"

    @State private var numPeople = 2
    @State private var checkAmount: Double = 0
    @FocusState private var amountIsFocused: Bool
    @State private var tipPercentage = 18

    // It's a trailing closure, dummy. Quit trying to put an equal sign in
    // there. That is grug brain.
    var totalPerPerson: Double {
        // Because our range control is STUPID.
        let correctedNumPeople = Double(numPeople + 2)
        let tipMultiplier = 1.0 + Double(tipPercentage) / 100.0
        return (checkAmount * tipMultiplier) / correctedNumPeople
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(
                        "Amount",
                        value: $checkAmount,
                        format: .currency(code: currencyIdentifier)
                    ).keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                Section {
                    Picker(
                        "Number of People in Your Party",
                        selection: $numPeople
                    ) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("How much tip would you like to leave?") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(validTipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
            }
            Section {
                Text("Your Fair Share")
                Text(totalPerPerson, format: .currency(code: currencyIdentifier))
            }.navigationBarTitleDisplayMode(.inline) // Requires inline mode
                .toolbar {
                    if amountIsFocused {
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                    //                    ToolbarItem(placement: .principal) {
                    //                        HStack {
                    //                            Text("WeSplit").font(.headline)
                    //                            Image(systemName: "arrow.trianglehead.branch").foregroundColor(.gray)
                    //                        }
                    //                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
