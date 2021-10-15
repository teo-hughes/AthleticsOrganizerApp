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
    
    // The body of the MainView
    var body: some View {
        Spacer()
        VStack {
            
            NavigationView {// Scroll View to load the tournament cards
                ScrollView {
                    TournamentCardView()
                    TournamentCardView()
                    TournamentCardView()
                    TournamentCardView()
                    TournamentCardView()
                    TournamentCardView()
                    
                    Button( action: { presentAddNewTournamentScreen.toggle() }, label: {
                        Image(systemName: "plus")
                    })
                }
                
                
                
                Spacer()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("Tournaments")
            .sheet(isPresented: $presentAddNewTournamentScreen) {
                CreateTournamentView()
            }
        }
    }
}
