//
//  ContentView.swift
//  UnitConversion
//
//  Created by Raouf on 24/01/2024.
//

import SwiftUI

struct ContentView: View {
    private let LENGTH_UNITS = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    @State private var selectedSourceUnit: String = "Meters"
    @State private var selectedTargetUnit: String = "Miles"
    @State private var valueToConvert = 2.0
    @FocusState private var isFocused: Bool
    
    var convertedValue: Double {
        let meter = convertSourceToMeter(value: valueToConvert, unit: selectedSourceUnit)
        var targetValue = convertMeterToTarget(meter, unit: selectedTargetUnit)
        
        //targetValue.round(.toNearestOrAwayFromZero)
        return targetValue
    }
    
    func convertSourceToMeter(value: Double, unit: String) -> Double {
        switch unit {
            case LENGTH_UNITS[0]: // Meters
                return value
                
            case LENGTH_UNITS[1]: // Kilometers
                return value * 1000
                
            case LENGTH_UNITS[2]: // Feet
                return value * 0.3048
                
            case LENGTH_UNITS[3]: // Yards
                return value * 0.9144
                
            case LENGTH_UNITS[4]: // Miles
                return value * 1609.34
            
            default:
                return 0.0
        }
    }
    
    func convertMeterToTarget(_ meter: Double, unit: String) -> Double {
        switch unit {
            case LENGTH_UNITS[0]: // Meters
                return meter
                
            case LENGTH_UNITS[1]: // Kilometers
                return meter / 1000
                
            case LENGTH_UNITS[2]: // Feet
                return meter * 3.28084
                
            case LENGTH_UNITS[3]: // Yards
                return meter * 1.09361
                
            case LENGTH_UNITS[4]: // Miles
                return meter * 0.000621371
                
            default:
                return 0.0
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Source Unit") {
                    Picker("Source Unit", selection: $selectedSourceUnit) {
                        ForEach(LENGTH_UNITS, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section("Target Unit") {
                    Picker("Target Unit", selection: $selectedTargetUnit) {
                        ForEach(LENGTH_UNITS, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                
                Section("\(selectedSourceUnit)") {
                    TextField("", value: $valueToConvert, format: .number)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                }
                
                Section("\(selectedTargetUnit)") {
                    Text(convertedValue, format: .number)
                }
            }
            .navigationTitle("Unit Conversion")
            //.navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
