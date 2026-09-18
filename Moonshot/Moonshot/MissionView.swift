//
//  MissionView.swift
//  Moonshot
//
//  Created by Hank Gay on 9/13/26.
//

import SwiftUI

struct MissionView: View {

    let mission: Mission
    let astronauts: [String: Astronaut]

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.astronauts = astronauts
    }

    var body: some View {
        ScrollView {
            VStack {
                Image(mission.badge)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.top)

                HStack {
                    Text("Launch Date:")
                        .font(.callout.bold())
                    Text(mission.formattedLaunchDate)
                        .font(.callout.bold())
                }

                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.lightBackground)
                    .padding(.vertical)

                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)

                    Text(mission.description)

                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)

                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)

                CrewCarouselView(mission: mission, astronauts: astronauts)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
