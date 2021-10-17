//
//  TournamentView.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 17/10/2021.
//

import SwiftUI

// This view will provide info surrounding the app's functions
struct TournamentView: View {
    
    @State var tournament: Tournament
    
    // The body of the InfoView
    var body: some View {
        Text(tournament.name)
            .padding()
    }
}

