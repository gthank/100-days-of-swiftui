//
//  ContentView.swift
//  BetterRest
//
//  Created by Hank Gay on 7/15/26.
//

import CoreML
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

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isShowingAlert = false

    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let dateComponents = Calendar.current.dateComponents(
                [.hour, .minute],
                from: wakeupTime,
            )
            let hour = dateComponents.hour ?? 0
            let minutes = dateComponents.minute ?? 0
            let wake = Double(hour * 60 * 60 + minutes * 60)
            let prediction = try model.prediction(
                wake: wake,
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeCounter),
            )
            let sleepTime = wakeupTime - prediction.actualSleep
            alertTitle = "Your ideal bedtime is…"
            alertMessage = "\(sleepTime.formatted(date: .omitted, time: .shortened))"
        } catch {
            alertTitle = "Well 💩"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        isShowingAlert = true
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("When do you want to wake up?") {
                    DatePicker(
                        "Please enter a time",
                        selection: $wakeupTime,
                        in: Date.now...,
                        displayedComponents: .hourAndMinute,
                    ).labelsHidden()
                }
                Section("Desired amount of sleep") {
                    Stepper(
                        "\(sleepAmount.formatted()) hours",
                        value: $sleepAmount,
                        in: 4...12,
                        step: 0.25,
                    )
                }
                Section("How many cups a day?") {
                    Stepper(
                        "^[\(coffeeCounter) cup](inflect: true)",
                        value: $coffeeCounter,
                        in: 0...20,
                        step: 1,
                    )
                }
            }.navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }.alert(alertTitle, isPresented: $isShowingAlert) {
                Button("OK") { } // The empty trailing closure ALWAYS throws me, for whatever reason.
            } message: {
                Text(alertMessage)
            }
        }
    }
}

#Preview {
    ContentView()
}
