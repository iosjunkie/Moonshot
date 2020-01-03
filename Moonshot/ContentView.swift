//
//  ContentView.swift
//  Moonshot
//
//  Created by Jules Lee on 1/3/20.
//  Copyright © 2020 Jules Lee. All rights reserved.
//

import SwiftUI

enum Mode: String, Identifiable, CaseIterable {
    case launchDates = "Launch Dates"
    case crewNames = "Crew Names"
    
    var id: UUID {
        return UUID()
    }
}

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var mode = Mode.launchDates
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Group {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)

                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            if self.mode == Mode.launchDates {
                                Text(mission.formattedLaunchDate )
                            } else {
                                Text(self.crewNames(mission: mission))
                            }
                        }
                    }
                }
            }
            .navigationBarItems(leading: Text("Moonshot").font(.title), trailing: Picker(selection: $mode, label: Text("Preferred View")) {
                    ForEach(Mode.allCases) {
                        Text($0.rawValue).tag($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            )
        }
    }
    
    func crewNames(mission: Mission) -> String {
        var names = ""
        for member in mission.crew {
            names += member.name + " "
        }
        
        return names
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
