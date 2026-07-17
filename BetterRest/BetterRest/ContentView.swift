//
//  ContentView.swift
//  BetterRest
//
//  Created by Hank Gay on 7/15/26.
//

import SwiftUI

extension Calendar {
    var tomorrowAt7AM: Date {
        let now = Date.now
        let targetComponents = DateComponents(hour: 7, minute: 0, second: 0)
        // If we wind up in a place where we can't find 7AM the next day, then we
        // probably have bigger fish to fry. I'm going unsafe unwrap.
        return Calendar.current.nextDate(
            after: now,
            matching: targetComponents,
            matchingPolicy: .nextTime,
        )!
    }
}

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeupTime = Calendar.current.tomorrowAt7AM
    @State private var coffeeCounter = 1

    func calculateBedtime() {
        // no-op for now
    }

    var body: some View {
        NavigationStack {
            VStack {
                Text("When do you want to wake up?").font(.headline)
                DatePicker(
                    "Please enter a time",
                    selection: $wakeupTime,
                    in: Date.now...,
                    displayedComponents: .hourAndMinute,
                ).labelsHidden()
                Text("Desired amount of sleep").font(.headline)
                Stepper(
                    "\(sleepAmount.formatted()) hours",
                    value: $sleepAmount,
                    in: 4...12,
                    step: 0.25,
                )
                Text("How many cups a day?").font(.headline)
                Stepper(
                    "\(coffeeCounter) cups",
                    value: $coffeeCounter,
                    in: 0...20,
                    step: 1,
                )
            }.navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
        }
    }
}

#Preview {
    ContentView()
}
