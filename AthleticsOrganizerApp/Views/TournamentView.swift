//
//  TournamentView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 17/10/2021.
//


// Importing SwiftUI
import SwiftUI


// This view is what is shown when a tournament is pressed
struct TournamentView: View {
    
    
    // Fetch the tournament and viewModel as parameters
    @State var tournament: Tournament
    @StateObject var viewModel: TournamentsViewModel
    
    // To show the sheet to add new atheltes/teams
    @State private var presentAddNewAthletesScreen = false
    
    
    // The body of the TournamentView
    var body: some View {
        
        NavigationView {
        
        // VStack to show all the events
        VStack {
            
            // List which will have each event inside
            List {
                
                // For each loop which goes through all the events in the tournamnet
                ForEach(0..<tournament.Events.count) { n in
                    
                    // Display a navigation olink which will go to the specific EventView
                    NavigationLink(destination: EventView(event: tournament.Events[n], tournamentAthletes: tournament.Athletes, tournamentName: tournament.name), label: {
                        
                        // Shown as an EventCardView
                        EventCardView(event: tournament.Events[n])
                    })
                }
            }
            
            // Spacer to move the events to the top
            Spacer()
            
            // Button to add teams and athletes
            Text("Add Teams and Athletes")
            
            // When the button is pressed, it toggles presentAddNewAthletesScreen
            Button( action: {
                presentAddNewAthletesScreen.toggle()
            }, label: {
                
                // Shows a +
                Image(systemName: "plus")
                    .font(.system(size: 25))
            })
        }
        // Shows the AddAthletesView if the presentAddNewAthletesScreen is true
        .sheet(isPresented: $presentAddNewAthletesScreen) {
            AddAthletesView(tournamentName: tournament.name, events: tournament.Events, athletes: tournament.Athletes)
        }
    
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .toolbar {
            
            // Add to the toolbar on the top right
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                
                Button( action: {

                }, label: {
                    
                    Text("Edit")
                    // Shows a refresh button
                    Image(systemName: "pencil.circle")
                        .font(.system(size: 25))
                })
            }
            // Add to the toolbar on the top left
            ToolbarItemGroup(placement: .navigationBarLeading) {
                
                Button( action: {

                }, label: {
                    
                    Text("Delete")
                    // Shows a refresh button
                    Image(systemName: "delete.right")
                        .font(.system(size: 25))
                })
            }
        }
    }
}
