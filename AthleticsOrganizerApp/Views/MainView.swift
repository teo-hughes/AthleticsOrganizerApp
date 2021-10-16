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
    
    @State private var presentAddNewTournamentScreen = false
    
    @ObservedObject private var viewModel = TournamentsViewModel()
    
    // The body of the MainView
    var body: some View {
        Spacer()
        VStack {
            
            NavigationView {// Scroll View to load the tournament cards
                ScrollView {
                    /*List(viewModel.tournaments) { tournament in
                        VStack(alignment: .leading) {
                            Text(tournament.name)
                                .font(.headline)
                            Text(tournament.location)
                                .font(.headline)
                            Text(tournament.date)
                                .font(.headline)
                            Text(tournament.allEvents)
                                .font(.headline)
                        }
                    }*/
                    
                    Button( action: { presentAddNewTournamentScreen.toggle() }, label: {
                        Image(systemName: "plus")
                    })
                }
                
                
                
                Spacer()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear() {
                self.viewModel.fetchData()
            }
            .navigationBarTitle("Tournaments")
            .sheet(isPresented: $presentAddNewTournamentScreen) {
                CreateTournamentView()
            }
        }
    }
}
