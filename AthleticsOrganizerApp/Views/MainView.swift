//
//  MainView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 18/09/2021.
//

import SwiftUI

// This view will be where you can choose a tournament etc.
struct MainView: View {
    
    @ObservedObject var tournamentViewModel: TournamentViewModel
    
    // The body of the MainView
    var body: some View {
        Spacer()
        VStack {
            
            ScrollView {
                TournamentCardView(tournamentViewModel: TournamentViewModel())
                TournamentCardView(tournamentViewModel: TournamentViewModel())
                TournamentCardView(tournamentViewModel: TournamentViewModel())
                TournamentCardView(tournamentViewModel: TournamentViewModel())
                TournamentCardView(tournamentViewModel: TournamentViewModel())
                TournamentCardView(tournamentViewModel: TournamentViewModel())
            }
        }
    }
}
