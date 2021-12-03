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
    @StateObject var userViewModel: UserViewModel
    
    // To show the sheet to add new atheltes/teams
    @State private var presentEditTournamentScreen = false
    @State private var presentAddNewAthletesScreen = false
    @State private var presentAddUsersScreen = false
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var presentAlert = false
    
    
    // The body of the TournamentView
    var body: some View {
        
        
        
        // VStack to show all the events
        VStack {
            
            HStack {
                
                Button(action: {
                    presentEditTournamentScreen.toggle()
                }, label: {
                    Text("Edit")
                    Image(systemName: "pencil.circle")
                })
                .sheet(isPresented: $presentEditTournamentScreen) {
                    EditTournamentView(tournament: tournament)
                }
                
                Spacer()
                
                Button(action: {
                    presentAddUsersScreen.toggle()
                }, label: {
                    Text("Add Users")
                    Image(systemName: "person.crop.circle.badge.plus")
                })
                .sheet(isPresented: $presentAddUsersScreen) {
                    AddUsersView()
                }
                
                Spacer()
                
                Button(action: {
                    
                    presentAlert.toggle()
                    
                }, label: {
                    Text("Delete")
                    Image(systemName: "delete.left")
                })
                .alert(isPresented: $presentAlert) {
                    Alert(title: Text("Delete \(tournament.name)"), message: Text("Deleting will permanently remove the tournament"), primaryButton: .destructive(Text("Delete")) {
                        viewModel.deleteTournament(tournamentName: tournament.name)
                        self.presentationMode.wrappedValue.dismiss()
                    }, secondaryButton: .cancel())
                }
            }
            .padding()
            
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
            // Shows the AddAthletesView if the presentAddNewAthletesScreen is true
            .sheet(isPresented: $presentAddNewAthletesScreen) {
                AddAthletesView(tournamentName: tournament.name, tournament: tournament, events: tournament.Events, athletes: tournament.Athletes)
            }
        }
        
    }
}
