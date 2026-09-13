//
//  Mission.swift
//  Moonshot
//
//  Created by Hank Gay on 9/13/26.
//

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
