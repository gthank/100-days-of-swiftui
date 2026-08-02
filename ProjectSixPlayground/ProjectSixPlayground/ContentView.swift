//
//  ContentView.swift
//  ProjectSixPlayground
//
//  Created by Hank Gay on 7/29/26.
//

import SwiftUI

struct ContentView: View {
    @State private var enabled = false

    var body: some View {
        Button("Tap me") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .foregroundStyle(.white)
        .background(enabled ? .blue : .red)
        .animation(nil, value: enabled)
        .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
        .animation(.spring(duration: 1, bounce: 0.6), value: enabled)
    }
}

#Preview {
    ContentView()
}
