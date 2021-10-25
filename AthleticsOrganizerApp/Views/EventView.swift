//
//  EventView.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 18/10/2021.
//

import SwiftUI

// This view will provide info surrounding the app's functions
struct EventView: View {
    
    @State var event: Event
    @State var tournamentAthletes: [Athlete]
    
    @State private var presentAddNewAthletesScreen = false
    
    // The body of the InfoView
    var body: some View {
        
        VStack {
            
            Spacer()
            Text("Add Times")
            Button( action: { presentAddNewAthletesScreen.toggle() }, label: {
                Image(systemName: "plus")
                    .font(.system(size: 25))
            })
        }
        .sheet(isPresented: $presentAddNewAthletesScreen) {
            AddTimesView()
        }
    }
}

