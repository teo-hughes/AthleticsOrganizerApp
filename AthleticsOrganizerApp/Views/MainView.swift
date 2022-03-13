//
//  MainView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 18/09/2021.
//


// Importing SwiftUI and Foundation
import SwiftUI
import Foundation


// This view will display the tournaments
struct MainView: View {
    
    
    // To show the sheet to add a new tournament
    @State private var presentAddNewTournamentScreen = false
    
    // Connect to the tournaments view model to fetch data from firebase
    @StateObject var viewModel = TournamentsViewModel()
    
    
    // The body of the MainView
    var body: some View {
        
        
        // NavigationView so the user can navigate to and from a tournament
        NavigationView {
            
            // VStack to show all the tournaments
            VStack {
                
                // List to display each tournament separately
                List {
                    
                    // If there are tournaments
                    if !viewModel.tournaments.isEmpty {
                        
                        // For each loop which goes through all the tournaments
                        ForEach(0..<viewModel.tournaments.count, id: \.self) { n in
                            

                            // Display a navigation link which will go to the specific tournamentView
                            NavigationLink(destination: TournamentView(tournament: viewModel.tournaments[n], viewModel: viewModel), label: {
                            
                                // Shown as a tournamentCardView
                                TournamentCardView(tournament: viewModel.tournaments[n])
                            })
                        }
                    }
                }
                
                
                // Spacer to move the tournaments to the top
                Spacer()
                
                // Text to precede the button to create a tournament
                Text("Create Tournament")
                
                // Button to create a tournament
                Button( action: {
                    
                    // Shows the CreateTournamentView
                    presentAddNewTournamentScreen.toggle()
                }, label: {
                    
                    // Shows a +
                    Image(systemName: "plus")
                        .font(.system(size: 25))
                })
            }
            .navigationBarTitle("Tournaments")
            // The toolbar is where you put items you want at the top
            .toolbar {
                
                // Add to the toolbar on the top right
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                    // A button which fetches the tournament names and then all the tournaments from firestore
                    Button( action: {
                        viewModel.fetch()
                    }, label: {
                        
                        // Shows a refresh button
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 25))
                    })
                }
            }
        }
        .onAppear {
            
            // Fetch the view model when this view appears
            viewModel.fetch()
        }
        .edgesIgnoringSafeArea(.all)
        .navigationViewStyle(StackNavigationViewStyle())
        
        // Shows the CreateTournamentView if the presentAddNewTournamentScreen is true
        .sheet(isPresented: $presentAddNewTournamentScreen) {
            CreateTournamentView()
        }
    }
}


