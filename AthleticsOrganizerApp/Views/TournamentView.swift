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
    
    // Variable which is the mode of the sheet (allows us to dismiss it)
    @State private var presentAddNewAthletesScreen = false
    
    
    // The body of the TournamentView
    var body: some View {
        
        
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
            Button( action: { presentAddNewAthletesScreen.toggle() }, label: {
                
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
}
