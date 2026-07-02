//
//  ContentView.swift
//  Convert-o-matic
//
//  Created by Hank Gay on 7/2/26.
//

import SwiftUI

struct ContentView: View {
    private let allowedTempUnits: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]

    enum TempUnit : String, CaseIterable, Identifiable {
        case celsius = "Celsius"
        case fahrenheit = "Fahrenheit"
        case kelvin = "Kelvin"

        var id: String { self.rawValue }

        var unit: UnitTemperature {
            switch self {
            case .celsius: return .celsius
            case .fahrenheit: return .fahrenheit
            case .kelvin: return .kelvin
            }
        }
    }

    @State private var tempInput = Measurement(value: 23, unit: UnitTemperature.celsius)
    @State private var tempInputUnit = UnitTemperature.celsius
    @State private var tempOutputUnit = UnitTemperature.fahrenheit
    private var tempOutput: Measurement<UnitTemperature> {
        return tempInput.converted(to: tempOutputUnit)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Temperature \(Image(systemName: "thermometer.variable"))")) {
                    HStack {
                        TextField("Input", value: $tempInput.value, format: .number).keyboardType(.decimalPad)
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
