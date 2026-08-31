//
//  ContentView.swift
//  Moonshot
//
//  Created by Hank Gay on 8/31/26.
//

import SwiftUI

struct CustomText: View {
    let text: String

    var body: some View {
        Text(text)
    }

    init(_ text: String) {
        print("Creating a _new_ CustomText: \(text)")
        self.text = text
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(0..<100) {
                    CustomText("Item \($0)").font(.title)
                }
            }
        }
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(0..<100) {
                    CustomText("Item \($0)").font(.title)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
