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
    @StateObject var tournamentViewModel = TournamentViewModel()
    
    // The body of the TournamentCardView
    var body: some View {
        
        // UI of card
        RoundedRectangle(cornerRadius: 10)
            .fill(clicked ? Color.blue: Color.red)
            .frame(height: 150)
            .overlay(
                // Information inside the card
                ZStack {
                    Text(tournamentViewModel.tournament.name)
                        .foregroundColor(Color.black)
                        .font(.custom("Avenir", size:25))
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
