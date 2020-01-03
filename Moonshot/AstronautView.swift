//
//  AstronautView.swift
//  Moonshot
//
//  Created by Jules Lee on 1/3/20.
//  Copyright © 2020 Jules Lee. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    var matchedMissions: [Mission]
    init(astronaut: Astronaut) {
        matchedMissions = [Mission]()

        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        
        
        for mission in missions {
            if let _ = mission.crew.first(where: { $0.name == astronaut.id }) {
                matchedMissions.append(mission)
            }
        }
        self.astronaut = astronaut
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                    .layoutPriority(1)
                    Spacer(minLength: 25)
                    ForEach(self.matchedMissions) { mission in
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)

                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .font(.headline)
                                Text(mission.formattedLaunchDate )
                            }

                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
                Spacer(minLength: 25)
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
