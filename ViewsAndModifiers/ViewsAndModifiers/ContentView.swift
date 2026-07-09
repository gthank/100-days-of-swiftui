//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Hank Gay on 7/9/26.
//

import SwiftUI

struct ContentView: View {
    var motto1: some View {
        Text("Draco dormiens")
    }
    let motto2 = Text("nunquam titillandus")

    @ViewBuilder var spells: some View {
        Text("Alohomora")
        Text("Petrificus Totalis")
        Text("Wingardium Leviosa")
    }

    var body: some View {
        VStack {
            Text("Hogwarts School Motto").font(.largeTitle)
            VStack {
                motto1.foregroundStyle(.red)
                motto2.foregroundStyle(.blue)
            }
            .padding()
            .font(.title)
            Spacer()
            VStack {
                Text("Spells").font(.largeTitle)
                spells
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
