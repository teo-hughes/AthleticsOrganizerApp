//
//  MainView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 18/09/2021.
//

import SwiftUI

// This view will be where you can choose a tournament etc.
struct MainView: View {
    
    //@ObservedObject var tournamentViewModel: TournamentViewModel
    
    // The body of the MainView
    var body: some View {
        Spacer()
        VStack {
            
            // Scroll View to load the tournament cards
            ScrollView {
                TournamentCardView()
                TournamentCardView()
                TournamentCardView()
                TournamentCardView()
                TournamentCardView()
                TournamentCardView()
            }
        }
    }
}
