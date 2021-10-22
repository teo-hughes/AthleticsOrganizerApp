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
        //Text(tournament.name)
          //  .padding()
        
        List {
            ForEach(tournament.Events) { event in
                NavigationLink(destination: EventView(event: event), label: {
                    EventCardView(event: event)
                })
            }
        }

        /*}
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear() {
            self.viewModel.fetchData()
        }*/
    }
}

