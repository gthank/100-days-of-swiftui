//
//  ContentView.swift
//  Convert-o-matic
//
//  Created by Hank Gay on 7/2/26.
//

import SwiftUI

struct ContentView: View {
    private let allowedTempUnits: [Dimension] = [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin]

    @State private var tempInput: Double = 0
    @State private var tempInputUnit: Dimension = UnitTemperature.celsius
    @State private var tempOutputUnit: Dimension = UnitTemperature.fahrenheit
    private var tempOutput: Measurement<Dimension> {
        let inputAsMeasurement = Measurement(value: tempInput, unit: tempInputUnit)
        return inputAsMeasurement.converted(to: tempOutputUnit)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Temperature \(Image(systemName: "thermometer.variable"))")) {
                    HStack {
                        TextField("Input", value: $tempInput, format: .number).keyboardType(.decimalPad)
                        Spacer()
                        Text("\(tempOutput.formatted())")
                    }
                    Picker("Input Unit", selection: $tempInputUnit) {
                        ForEach(allowedTempUnits, id: \.self) { unit in
                            Text(unit.symbol).tag(unit)
                        }
                    }.pickerStyle(.segmented)
                    Picker("Output Unit", selection: $tempOutputUnit) {
                        ForEach(allowedTempUnits, id: \.self) { unit in
                            Text(unit.symbol).tag(unit)
                        }
                    }.pickerStyle(.segmented)
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
