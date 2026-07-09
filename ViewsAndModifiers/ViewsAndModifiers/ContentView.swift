//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Hank Gay on 7/9/26.
//

import SwiftUI


struct ContentView: View {
    struct GridStack<Content: View> : View {
        let rows: Int
        let cols: Int
        @ViewBuilder let content: (Int, Int) -> Content

        var body: some View {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<cols, id: \.self) { col in
                        content(row, col)
                    }
                }
            }
        }
    }

    var body: some View {
        GridStack(rows: 4, cols: 4) { row, col in
            Image(systemName: "\(row * 4 + col).circle")
            Text("R\(row) C\(col)")
        }
    }
}

#Preview {
    ContentView()
}
