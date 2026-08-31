//
//  ContentView.swift
//  Moonshot
//
//  Created by Hank Gay on 8/31/26.
//

import SwiftUI

struct Address: Codable {
    let street: String
    let city: String
}

struct User: Codable {
    let name: String
    let address: Address
}

struct ContentView: View {
    var body: some View {
        let layout = [
            GridItem(.adaptive(minimum: 80, maximum: 120)),
            GridItem(.adaptive(minimum: 80, maximum: 120)),
            GridItem(.adaptive(minimum: 80, maximum: 120)),
        ]

        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(0..<1000) {
                    Text("Vertical \($0)")
                }
            }
        }
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(0..<1000) {
                    Text("Horizontal \($0)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
