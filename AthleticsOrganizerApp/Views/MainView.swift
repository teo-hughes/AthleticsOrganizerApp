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
    
    @StateObject var viewModel = TournamentsViewModel()
    


    
    
    // The body of the MainView
    var body: some View {
        Spacer()
            
        
        NavigationView {// Scroll View to load the tournament cards
            VStack {
                List {
                    ForEach(viewModel.tournaments) { tournament in
                        TournamentCardView(tournament: tournament)
                    }
                }
                        
                Text("Create Tournament")
                Button( action: { presentAddNewTournamentScreen.toggle() }, label: {
                    Image(systemName: "plus")
                })
                    
                Spacer()
            }
        }
        .onAppear() {
            self.viewModel.fetchData()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("Tournaments")
        .sheet(isPresented: $presentAddNewTournamentScreen) {
            CreateTournamentView()
        }
    }
}



