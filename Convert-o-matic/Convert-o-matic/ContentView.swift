//
//  ContentView.swift
//  Convert-o-matic
//
//  Created by Hank Gay on 7/2/26.
//

import SwiftUI

struct ContentView: View {
    enum UnitOfLength {
        case Meters
        case Kilometers
        case Feet
        case Yards
        case Miles
    }
    enum UnitOfTime {
        case Seconds
        case Minutes
        case Hours
        case Days
    }
    enum UnitOfVolume {
        case Mililiters
        case Liters
        case Cups
        case Pints
        case Quarts
        case Gallons
    }

    @State private var tempInput : Double = 0
    @State private var tempInputUnit = UnitTemperature.celsius
    @State private var tempOutputUnit = UnitTemperature.fahrenheit
    private var tempOutput: Measurement<UnitTemperature> {
        let tempAsMeasurement = Measurement(value: tempInput, unit: tempInputUnit)
        return tempAsMeasurement.converted(to: tempOutputUnit)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Temperature \(Image(systemName: "thermometer.variable"))")) {
                    HStack {
                        TextField("Input", value: $tempInput, format: .number).keyboardType(.numberPad)
                        Spacer()
                        Text("\(tempOutput.formatted())")
                    }
                }
                Section(header: Text("Length \(Image(systemName: "lines.measurement.horizontal.aligned.bottom"))")) {

                }
                Section(header: Text("Time \(Image(systemName: "clock"))")) {

                }
                Section(header: Text("Volume \(Image(systemName: "flask"))")) {

                }
            }.navigationTitle("Convert-o-matic!")
        }
    }
}

#Preview {
    ContentView()
}
