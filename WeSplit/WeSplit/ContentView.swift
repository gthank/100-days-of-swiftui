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
    @State private var tipPercentage = 18

    var totalPerPerson: Double {
        let correctedNumPeople = Double(numPeople + 2) // Because our range control is STUPID
        let tipMultiplier = 1.0 + Double(tipPercentage) / 100.0
        return (checkAmount * tipMultiplier) / correctedNumPeople
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currencyIdentifier)).keyboardType(.decimalPad)
                }
                Section {
                    Picker("Number of People in Your Party", selection: $numPeople) {
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

            }.navigationTitle("WeSplit \(Image(systemName: "arrow.trianglehead.branch"))")
        }
        Section {
            Text("Your Fair Share")
            Text(totalPerPerson, format: .currency(code: currencyIdentifier))
        }
    }
}

#Preview {
    ContentView()
}
