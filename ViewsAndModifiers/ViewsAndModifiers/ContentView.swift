//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Hank Gay on 7/9/26.
//

import SwiftUI

struct ContentView: View {
    struct CapsuleText: View {
        var text: String
        var body: some View {
            Text(text)
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(.capsule)
        }
    }

    var body: some View {
        VStack(spacing: 10) {
            CapsuleText(text: "First")
            CapsuleText(text: "Second")
        }
    }
}

#Preview {
    ContentView()
}
