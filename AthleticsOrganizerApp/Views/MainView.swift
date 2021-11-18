//
//  MainView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 18/09/2021.
//


// Importing SwiftUI
import SwiftUI
import Foundation


// This view will display the tournaments
struct MainView: View {
    
    
    // To show the sheet to add a new tournamnet
    @State private var presentAddNewTournamentScreen = false
    
    // Connect to the tournaments view model to fetch data
    @StateObject var viewModel = TournamentsViewModel()
    
    
    // The body of the MainView
    var body: some View {
        
        // NavigationView so the user can navigate to and from a tournament
        NavigationView {
            
            // VStack to show all the tournaments
            VStack {
                
                // List which will have each tournament inside
                List{
                    
                    // For each loop which goes through all the tournaments
                    ForEach(0..<viewModel.tournaments.count, id: \.self) { n in
                        
                        // Display a navigation link which will go to the specific tournamentView
                        NavigationLink(destination: TournamentView(tournament: viewModel.tournaments[n], viewModel: viewModel), label: {
                            
                            // Shown as a tournamentCardView
                            TournamentCardView(tournament: viewModel.tournaments[n])
                        })
                    }
                }
                
                // Spacer to move the tournaments to the top
                Spacer()
                
                // Button to create a tournament
                Text("Create Tournament")
                
                // When the button is pressed, it toggles presentAddNewTournamentScreen
                Button( action: { presentAddNewTournamentScreen.toggle() }, label: {
                    
                    // Shows a +
                    Image(systemName: "plus")
                        .font(.system(size: 25))
                })
            }
            .navigationBarTitle("Tournaments")
            // Refresh button to load the tournaments
            .toolbar {
                
                // Add to the toolbar on the top right
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                    // A button which fetches the tournament names and then all the tournaments from firestore
                    Button( action: {
                        self.viewModel.fetchTournamentNames()
                        for name in viewModel.names {
                            self.viewModel.fetchData(tournamentCollectionName: name)
                        }
                    }, label: {
                        
                        // Shows a refresh button
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 25))
                    })
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationViewStyle(StackNavigationViewStyle())
        // When it appears fetches the tournament names and then all the tournaments from firestore
        .onAppear(perform: {
            self.viewModel.fetchTournamentNames()
            for name in viewModel.names {
                self.viewModel.fetchData(tournamentCollectionName: name)
            }
        })
        // Shows the CreateTournamentView if the presentAddNewTournamentScreen is true
        .sheet(isPresented: $presentAddNewTournamentScreen) {
            CreateTournamentView()
        }
    }
}
