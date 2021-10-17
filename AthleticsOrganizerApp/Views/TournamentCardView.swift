//
//  TournamentCardView.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 09/10/2021.
//

import SwiftUI

// This View will show the tournament card
struct TournamentCardView: View {
    
    // variables which decided the states of the card
    @State private var clicked = false
    
    // Calling the viewModel for the tournamentViewModel
    @State var tournament: Tournament
    
    // The body of the TournamentCardView
    var body: some View {
        
        // UI of card
        RoundedRectangle(cornerRadius: 10)
            .fill(clicked ? Color.blue: Color.red)
            .frame(height: 150)
            .overlay(
                // Information inside the card
                VStack {
                    Text(tournament.name)
                        .foregroundColor(Color.black)
                        .font(.custom("Avenir", size:25))
                    HStack {
                        Text("Location: \(tournament.location)")
                            .foregroundColor(Color.black)
                            .font(.custom("Avenir", size:15))
                            .padding()
                        Text("Date: \(tournament.date)")
                            .foregroundColor(Color.black)
                            .font(.custom("Avenir", size:15))
                            .padding()
                        Text("Events: \(tournament.allEvents)")
                            .foregroundColor(Color.black)
                            .font(.custom("Avenir", size:15))
                            .padding()
                    }
                }.padding()
            )
            // What happens when tapped
            .onTapGesture {
                withAnimation {
                    clicked.toggle()
                }
            }
    }
}
