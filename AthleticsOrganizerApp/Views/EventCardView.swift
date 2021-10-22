//
//  EventCardView.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 18/10/2021.
//

import SwiftUI

// This View will show the tournament card
struct EventCardView: View {
    
    
    
    // Calling the viewModel for the tournamentViewModel
    @State var event: Event
    
    // The body of the TournamentCardView
    var body: some View {
        
        VStack {
            // UI of card
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red)
                .frame(height: 150)
                .overlay(
                    // Information inside the card
                    VStack {
                        Text(event.event_name)
                            .foregroundColor(Color.black)
                            .font(.custom("Avenir", size:25))
                        
                    }.padding()
                )
        }
        
    }
}
