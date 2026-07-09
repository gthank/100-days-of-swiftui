//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Hank Gay on 7/9/26.
//

import SwiftUI

struct ContentView: View {
    struct Title: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding()
                .background(.blue)
                .clipShape(.rect(cornerRadius: 10))
        }
    }

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
            Spacer()
            Text("Hello, World!").modifier(Title())
            Spacer()
            CapsuleText(text: "First")
            CapsuleText(text: "Second")
            Spacer()
        }.padding()
    }
}

#Preview {
    ContentView()
}
