//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Hank Gay on 7/9/26.
//

import SwiftUI

let charcoal = Color(red: 0.4, green: 0.4, blue: 0.4)
let smokestreak = Color(red: 0.96, green: 0.96, blue: 0.96)

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

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(charcoal)
                .padding(5)
        }
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }

    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Text("Hello, World!").titleStyle()
            Spacer()
            CapsuleText(text: "First")
            CapsuleText(text: "Second")
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .watermarked(with: "Hacking with Swift")
        .background(smokestreak)
    }
}

#Preview {
    ContentView()
}
