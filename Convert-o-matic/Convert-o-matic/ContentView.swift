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

    private func wrapOutputTemp(_ tempToWrap: Double) -> Measurement<UnitTemperature> {
        return Measurement(value: tempToWrap, unit: tempOutputUnit)
    }

    @State private var tempInput : Double = 0
    @State private var tempInputUnit = UnitTemperature.celsius
    @State private var tempOutputUnit = UnitTemperature.fahrenheit
    private var tempOutput: Measurement<UnitTemperature> {
        switch tempInputUnit {
        case .fahrenheit:
            switch tempOutputUnit {
            case .fahrenheit:
                return wrapOutputTemp(tempInput)
            case .celsius:
                return wrapOutputTemp((tempInput - 32) / 1.8)
            case .kelvin:
                return wrapOutputTemp((tempInput - 32) / 1.8 + 273.15)
            default:
                // I should really probably do some sort of error, here
                return wrapOutputTemp(tempInput)
            }
        case .celsius:
            switch tempOutputUnit {
            case .fahrenheit:
                return wrapOutputTemp(tempInput * 1.8 + 32)
            case .celsius:
                return wrapOutputTemp(tempInput)
            case .kelvin:
                return wrapOutputTemp(tempInput + 273.15)
            default:
                // I should really probably do some sort of error, here
                return wrapOutputTemp(tempInput)
            }
        case .kelvin:
            switch tempOutputUnit {
            case .fahrenheit:
                return wrapOutputTemp((tempInput - 273.15) * 1.8 + 32)
            case .celsius:
                return wrapOutputTemp(tempInput - 273.15)
            case .kelvin:
                return wrapOutputTemp(tempInput)
            default:
                // I should really probably do some sort of error, here
                return wrapOutputTemp(tempInput)
            }
        default:
            // I should really probably do some sort of error, here
            return wrapOutputTemp(tempInput)
        }
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
