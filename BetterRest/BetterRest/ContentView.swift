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

    @State private var wakeUpNow = Calendar.current.tomorrowAt7AM

    var body: some View {
        VStack {
            Text("BetterRest").font(.largeTitle)
            Stepper(
                "Sleep \(sleepAmount.formatted()) hours",
                value: $sleepAmount,
                in: 4...12,
                step: 0.25,
            )
            DatePicker(
                "Please choose a date",
                selection: $wakeUpNow,
                in: Date.now...,
                displayedComponents: .hourAndMinute,
            ).labelsHidden()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
