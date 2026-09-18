//
//  CrewCarouselView.swift
//  Moonshot
//
//  Created by Hank Gay on 9/17/26.
//

import SwiftUI

struct CrewCarouselView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut

        var isCommand: Bool {
            "Command Pilot" == role || "Commander" == role
        }
    }

    let mission: Mission
    let crew: [CrewMember]

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.capsule)
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )

                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)

                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity( 0.5))
                            }
                        }
                        .padding()
                        .border(.lightBackground, width: crewMember.isCommand ? 2 : 0)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return CrewCarouselView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
