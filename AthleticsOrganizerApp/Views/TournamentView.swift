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
    @State private var presentEditTournamentScreen = false
    @State private var presentAddNewAthletesScreen = false
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var athleteNames: [String] = []
    @State private var athleteTeams: [String] = []
    @State private var athleteScores: [Int] = []
    @State private var athletePerformances: [Double] = []
    @State private var athleteToInsert: Int = 30000
    @State private var performanceToInsert: Double = 30.0
    @State private var nameToInsert: String = "Insert"
    @State private var teamToInsert: String = "Insert team"
    @State private var previous: Int = 0
    
    
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
                
                Button( action: {
                    viewModel.fetch()
                    athleteNames = []
                    athleteTeams = []
                    athleteScores = []
                    athletePerformances = []
                    
                    for event in tournament.Events {
                        for athlete in event.Athletes {
                            athleteNames.append(athlete.name)
                            athleteTeams.append(athlete.team)
                            athleteScores.append(athlete.scores[0])
                            athletePerformances.append(athlete.performances[0])
                        }
                    }
                    
                    for i in 1..<athleteNames.count {
                        athleteToInsert = athleteScores[i]
                        nameToInsert = athleteNames[i]
                        teamToInsert = athleteTeams[i]
                        performanceToInsert = athletePerformances[i]
                        
                        previous = i - 1
                        
                        while previous >= 0 && athleteScores[previous] > athleteToInsert {
                            
                            athleteScores[previous + 1] = athleteScores[previous]
                            athleteNames[previous + 1] = athleteNames[previous]
                            athleteTeams[previous + 1] = athleteTeams[previous]
                            athletePerformances[previous + 1] = athletePerformances[previous]
                            
                            previous = previous - 1
                        }
                        
                        athleteScores[previous + 1] = athleteToInsert
                        athleteNames[previous + 1] = nameToInsert
                        athleteTeams[previous + 1] = teamToInsert
                        athletePerformances[previous + 1] = performanceToInsert
                        
                    }
                    
                }, label: {
                    HStack {
                        Text("Load Scores")
                        // Shows a refresh button
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 25))
                    }
                })
                
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
            
            VStack {
                if !athleteNames.isEmpty {
                    ForEach(0..<athleteNames.count) { n in
                                
                        HStack {
                            Text(athleteNames[n])
                            Text(athleteTeams[n])
                            Text((round(athletePerformances[n] * 1000) / 1000).description)
                            Text(athleteScores[n].description)
                        }
                    }
                            
                }
                
                
            }
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

