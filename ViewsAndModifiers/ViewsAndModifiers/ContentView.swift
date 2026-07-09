//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Hank Gay on 7/9/26.
//

import SwiftUI

struct ContentView: View {
    private let charcoal = Color(red: 0.4, green: 0.4, blue: 0.4)
    private let whitesmoke = Color(red: 0.96, green: 0.96, blue: 0.96)
    @State private var isLight = true

    var body: some View {
        VStack {
            Button("Hello, World!") {
                isLight.toggle()
                // do nothing
            }
            .padding()
            .background(isLight ? whitesmoke : charcoal)
            .foregroundColor(isLight ? charcoal : whitesmoke)
            .font(.headline)
            .padding()
            .background(.red)
            .padding()
            .background(.white)
            .padding()
            .background(.blue)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
