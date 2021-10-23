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
    
    @State private var presentAddNewAthletesScreen = false
    
    // The body of the InfoView
    var body: some View {
        
        VStack {
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
            
            Spacer()
            Text("Add Teams and Athletes")
            Button( action: { presentAddNewAthletesScreen.toggle() }, label: {
                Image(systemName: "plus")
                    .font(.system(size: 25))
            })
        }
        .sheet(isPresented: $presentAddNewAthletesScreen) {
            AddAthletesView(tournamentName: tournament.name, events: tournament.Events)
        }
    }
    

}

