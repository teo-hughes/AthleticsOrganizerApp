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
    @StateObject var viewModel: TournamentsViewModel
    
    // The body of the InfoView
    var body: some View {
        
        List {
            ForEach(0..<tournament.Events.count) { n in
                NavigationLink(destination: EventView(event: tournament.Events[n]), label: {
                    EventCardView(event: tournament.Events[n])
                })
            }
        }
        .refreshable {
            self.viewModel.fetchData()
        }
    }
}

