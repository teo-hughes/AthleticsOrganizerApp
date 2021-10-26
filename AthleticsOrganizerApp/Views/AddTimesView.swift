//
//  AddTimesView.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 25/10/2021.
//

import SwiftUI

// This view will provide info surrounding the app's functions
struct AddTimesView: View {
    
    @State var event: Event
    @State var tournamentAthletes: [Athlete]
    
    
    @State var searchingFor = ""
    
    // The body of the InfoView
    var body: some View {
        Text("Add Times View")
        /*NavigationView {
            List {
                ForEach(tournamentAthletes, id: \.self) { athlete in
                    NavigationLink(destination: Text(athlete)) {
                        Text(athlete)
                    }
                }
            }
            .searchable(text: $searchingFor)
            .navigationTitle("Add Athletes")
        }*/
    }
    
   /* var results: [String] {
        if searchingFor.isEmpty {
            return tournamentAthletes
        } else {
            return tournamentAthletes.filter { $0.contains(searchingFor)}
        }
    }*/
}
