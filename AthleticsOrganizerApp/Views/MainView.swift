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
        
        
        
        NavigationView {
            VStack {
                List(viewModel.tournaments) { tournament in
                    NavigationLink(destination: TournamentView(tournament: tournament, viewModel: viewModel), label: {
                        TournamentCardView(tournament: tournament)
                    })
                }
                .refreshable {
                    self.viewModel.fetchData()
                }
                
                
                Spacer()
                Text("Create Tournament")
                Button( action: { presentAddNewTournamentScreen.toggle() }, label: {
                    Image(systemName: "plus")
                        .font(.system(size: 25))
                })
                
                //Spacer()
                
            }
            .navigationBarTitle("Tournaments")
            
            
        }
        .edgesIgnoringSafeArea(.all)
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear() {
            self.viewModel.fetchData()
        }
        .sheet(isPresented: $presentAddNewTournamentScreen) {
            CreateTournamentView()
        }
    }
}


