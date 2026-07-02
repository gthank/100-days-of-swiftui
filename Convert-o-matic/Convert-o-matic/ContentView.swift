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

    private let allowedLengthUnits: [Dimension] = [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles]
    @State private var lengthInput: Double = 0
    @State private var lengthInputUnit: Dimension = UnitLength.feet
    @State private var lengthOutputUnit: Dimension = UnitLength.meters
    private var lengthOutput: Measurement<Dimension> {
        let inputAsMeasurement = Measurement(value: lengthInput, unit: lengthInputUnit)
        return inputAsMeasurement.converted(to: lengthOutputUnit)
    }

    private let allowedTimeUnits: [Dimension] = [UnitDuration.seconds, UnitDuration.minutes, UnitDuration.hours]
    @State private var timeInput: Double = 0
    @State private var timeInputUnit: Dimension = UnitDuration.hours
    @State private var timeOutputUnit: Dimension = UnitDuration.seconds
    private var timeOutput: Measurement<Dimension> {
        let inputAsMeasurement = Measurement(value: timeInput, unit: timeInputUnit)
        return inputAsMeasurement.converted(to: timeOutputUnit)
    }

    private let allowedVolumeUnits: [Dimension] = [UnitVolume.milliliters, UnitVolume.liters, UnitVolume.cups, UnitVolume.pints, UnitVolume.quarts, UnitVolume.gallons]
    @State private var volumeInput: Double = 0
    @State private var volumeInputUnit: Dimension = UnitVolume.milliliters
    @State private var volumeOutputUnit: Dimension = UnitVolume.quarts
    private var volumeOutput: Measurement<Dimension> {
        let inputAsMeasurement = Measurement(value: volumeInput, unit: volumeInputUnit)
        return inputAsMeasurement.converted(to: volumeOutputUnit)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Temperature \(Image(systemName: "thermometer.variable"))")) {
                    Grid {
                        GridRow {
                            Text("Input")
                            Text("Output")
                        }
                        GridRow {
                            TextField("Input", value: $tempInput, format: .number).keyboardType(.decimalPad).frame(maxWidth: .infinity)
                            Text("\(tempOutput.formatted())").padding(0).frame(maxWidth: .infinity)
                        }
                        GridRow {
                            Picker("Input Unit", selection: $tempInputUnit) {
                                ForEach(allowedTempUnits, id: \.self) { unit in
                                    Text(unit.symbol).tag(unit)
                                }
                            }.pickerStyle(.menu)
                            Picker("Output Unit", selection: $tempOutputUnit) {
                                ForEach(allowedTempUnits, id: \.self) { unit in
                                    Text(unit.symbol).tag(unit)
                                }
                            }.pickerStyle(.menu)
                        }
                    }
                }

                Section(header: Text("Length \(Image(systemName: "lines.measurement.horizontal.aligned.bottom"))")) {
                    Grid {
                        GridRow {
                            Text("Input")
                            Text("Output")
                        }
                        GridRow {
                            TextField("Input", value: $lengthInput, format: .number).keyboardType(.decimalPad).frame(maxWidth: .infinity)
                            Text("\(lengthOutput.formatted())").padding(0).frame(maxWidth: .infinity)
                        }
                        GridRow {
                            Picker("Input Unit", selection: $lengthInputUnit) {
                                ForEach(allowedLengthUnits, id: \.self) { unit in
                                    Text(unit.symbol).tag(unit)
                                }
                            }.pickerStyle(.menu)
                            Picker("Output Unit", selection: $lengthOutputUnit) {
                                ForEach(allowedLengthUnits, id: \.self) { unit in
                                    Text(unit.symbol).tag(unit)
                                }
                            }.pickerStyle(.menu)
                        }
                    }
                }

                Section(header: Text("Time \(Image(systemName: "clock"))")) {
                    Grid {
                        GridRow {
                            Text("Input")
                            Text("Output")
                        }
                        GridRow {
                            TextField("Input", value: $timeInput, format: .number).keyboardType(.decimalPad).frame(maxWidth: .infinity)
                            Text("\(timeOutput.formatted())").padding(0).frame(maxWidth: .infinity)
                        }
                        GridRow {
                            Picker("Input Unit", selection: $timeInputUnit) {
                                ForEach(allowedTimeUnits, id: \.self) { unit in
                                    Text(unit.symbol).tag(unit)
                                }
                            }.pickerStyle(.menu)
                            Picker("Output Unit", selection: $timeOutputUnit) {
                                ForEach(allowedTimeUnits, id: \.self) { unit in
                                    Text(unit.symbol).tag(unit)
                                }
                            }.pickerStyle(.menu)
                        }
                    }
                }

                Section(header: Text("Volume \(Image(systemName: "flask"))")) {
                    Grid {
                        GridRow {
                            Text("Input")
                            Text("Output")
                        }
                        GridRow {
                            TextField("Input", value: $volumeInput, format: .number).keyboardType(.decimalPad).frame(maxWidth: .infinity)
                            Text("\(volumeOutput.formatted())").padding(0).frame(maxWidth: .infinity)
                        }
                        GridRow {
                            Picker("Input Unit", selection: $volumeInputUnit) {
                                ForEach(allowedVolumeUnits, id: \.self) { unit in
                                    Text(unit.symbol).tag(unit)
                                }
                            }.pickerStyle(.menu)
                            Picker("Output Unit", selection: $volumeOutputUnit) {
                                ForEach(allowedVolumeUnits, id: \.self) { unit in
                                    Text(unit.symbol).tag(unit)
                                }
                            }.pickerStyle(.menu)
                        }
                    }
                }
            }.navigationTitle("Convert-o-matic!")
        }
    }
}

#Preview {
    ContentView()
}
