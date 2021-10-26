//
//  SearchAthletesView.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 26/10/2021.
//

//
//  AddTimesView.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 25/10/2021.
//

import SwiftUI

// This view will provide info surrounding the app's functions
struct SearchAthletesView: View {
    
    @State var event: Event
    @State var tournamentAthletes: [Athlete]
    @State var chosenAgeGroup: String
    @State var chosenGender: String
    
    @State var AthleteNames: [String] = []
    
    
    @State var searchingFor = ""
    
    // The body of the InfoView
    var body: some View {

        NavigationView {
            List {
                ForEach(results, id: \.self) { athlete in
                    NavigationLink(destination: Text(athlete)) {
                        Text(athlete)
                    }
                }
            }
            .searchable(text: $searchingFor)
            .navigationTitle("Add Athletes")
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .onAppear(perform: {
            for athlete in tournamentAthletes {
                if athlete.age_group == chosenAgeGroup && athlete.gender == chosenGender {
                    AthleteNames.append(athlete.name)
                }
            }
        })
    }
    
    var results: [String] {
        if searchingFor.isEmpty {
            return AthleteNames
        } else {
            return AthleteNames.filter { $0.contains(searchingFor)}
        }
    }
}
