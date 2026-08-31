//
//  ContentView.swift
//  Moonshot
//
//  Created by Hank Gay on 8/31/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(.purty)
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { size, axis in
                    size * 0.8
                }
        }
    }
}

#Preview {
    ContentView()
}
