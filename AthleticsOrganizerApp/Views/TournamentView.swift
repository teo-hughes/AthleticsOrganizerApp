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
    
    // To show sheets to edit the tournament and add new athletes as well as a presentationMode
    @State private var presentEditTournamentScreen = false
    @State private var presentAddNewAthletesScreen = false
    @Environment(\.presentationMode) var presentationMode
    
    // Variables which will be used in the insertion sort
    @State private var athleteNames: [String] = []
    @State private var athleteTeams: [String] = []
    @State private var athleteScores: [Int] = []
    @State private var athletePerformances: [Double] = []
    @State private var athleteToInsert: Int = 30000
    @State private var performanceToInsert: Double = 30.0
    @State private var nameToInsert: String = "Insert"
    @State private var teamToInsert: String = "Insert team"
    @State private var previous: Int = 0
    
    // Presents an alert when you want to delete a tournament
    @State private var presentAlert = false
    
    
    // The body of the TournamentView
    var body: some View {
        
        
        // VStack to show all the events
        VStack {
            
            // HStack for the buttons at the top
            HStack {
                
                // Button to edit a tournament
                Button(action: {
                    
                    // Presents the Edit Tournament View
                    presentEditTournamentScreen.toggle()
                }, label: {
                    
                    // Shows the user it is an edit button
                    Text("Edit")
                    Image(systemName: "pencil.circle")
                })
                .sheet(isPresented: $presentEditTournamentScreen) {
                    
                    // Present EditTournamentView
                    EditTournamentView(tournament: tournament)
                }
                
                // Spacer to move the edit button to the left
                Spacer()
                
                // Button to load and sort the scores
                Button( action: {
                    
                    // Fetch the data and create variables
                    viewModel.fetch()
                    athleteNames = []
                    athleteTeams = []
                    athleteScores = []
                    athletePerformances = []
                    
                    // Process the data into those variables
                    for event in tournament.Events {
                        for athlete in event.Athletes {
                            athleteNames.append(athlete.name)
                            athleteTeams.append(athlete.team)
                            athleteScores.append(athlete.scores[0])
                            athletePerformances.append(athlete.performances[0])
                        }
                    }
                    
                    // Insertion sort to sort the scores
                    for i in 1..<athleteNames.count {
                        
                        // Variables that I will be "inserting"
                        athleteToInsert = athleteScores[i]
                        nameToInsert = athleteNames[i]
                        teamToInsert = athleteTeams[i]
                        performanceToInsert = athletePerformances[i]
                        
                        // Used to find the previous variable
                        previous = i - 1
                        
                        // While loop which will find the correct position of the variable
                        while previous >= 0 && athleteScores[previous] < athleteToInsert {
                            
                            // Swap the variables
                            athleteScores[previous + 1] = athleteScores[previous]
                            athleteNames[previous + 1] = athleteNames[previous]
                            athleteTeams[previous + 1] = athleteTeams[previous]
                            athletePerformances[previous + 1] = athletePerformances[previous]
                            
                            // Decrease previous by 1
                            previous = previous - 1
                        }
                        
                        // Storing the variable in the correct position
                        athleteScores[previous + 1] = athleteToInsert
                        athleteNames[previous + 1] = nameToInsert
                        athleteTeams[previous + 1] = teamToInsert
                        athletePerformances[previous + 1] = performanceToInsert
                    }
                }, label: {
                    
                    // UI of button
                    HStack {
                        Text("Load Scores")
                        // Shows a refresh button
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 25))
                    }
                })
                
                // Spacer to move the delete button to the right
                Spacer()
                
                // The button to delete a tournament
                Button(action: {
                    
                    // Presents the delete alert
                    presentAlert.toggle()
                }, label: {
                    
                    // UI of button
                    Text("Delete")
                    Image(systemName: "delete.left")
                })
                // Alert shown when button is pressed
                .alert(isPresented: $presentAlert) {
                    
                    // Show a warning to the user
                    Alert(title: Text("Delete \(tournament.name)"), message: Text("Deleting will permanently remove the tournament"), primaryButton: .destructive(Text("Delete")) {
                        
                        // Delete the tournament and dismiss the alert
                        viewModel.deleteTournament(tournamentName: tournament.name)
                        self.presentationMode.wrappedValue.dismiss()
                    }, secondaryButton: .cancel())
                }
            }
            .padding()
            
            
            // VStack which will show the sorted athletes
            VStack {
                
                // Check if I have loaded the athletes
                if !athleteNames.isEmpty {
                    
                    // Go through the athletes
                    ForEach(0..<athleteNames.count) { n in
                        
                        // Display the key details
                        HStack {
                            Text(athleteNames[n])
                            Text(athleteTeams[n])
                            
                            // Rounds the performance to 3 decimal places
                            Text((round(athletePerformances[n] * 1000) / 1000).description)
                            Text(athleteScores[n].description)
                        }
                    }
                }
            }
            
            
            // VStack which will have all the events inside
            VStack {
                
                // List which will display each event separately
                List {
                    
                    // For each loop which goes through all the events in the tournamnet
                    ForEach(0..<tournament.Events.count) { n in
                        
                        // Display a navigation link which will go to the specific EventView
                        NavigationLink(destination: EventView(event: tournament.Events[n], tournamentAthletes: tournament.Athletes, tournamentName: tournament.name), label: {
                            
                            // Shown as an EventCardView
                            EventCardView(event: tournament.Events[n])
                        })
                    }
                }
            }
            
            // Spacer to move the events to the top
            Spacer()
            
            // Text that precedes the button to add teams and athletes
            Text("Add Teams and Athletes")
            
            // Button to add teams and athletes
            Button( action: {
                
                // When pressed shows the AddAthletesView
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
