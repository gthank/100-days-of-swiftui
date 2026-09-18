//
//  ContentView.swift
//  Moonshot
//
//  Created by Hank Gay on 8/31/26.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State var displayModeButtonLabel = "Grid"
    @State var isGrid: Bool = true

    var body: some View {
        NavigationStack {
            Group {
                if isGrid {
                    MissionGrid(missions: missions, astronauts: astronauts)
                } else {
                    MissionList(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(displayModeButtonLabel) {
                        isGrid.toggle()
                        displayModeButtonLabel = isGrid ? "Grid" : "List"
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
