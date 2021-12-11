//
//  AthleteViewModel.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 23/10/2021.
//


// Importing FirebaseFirestore to connect to firebase
import FirebaseFirestore


// The class for the viewModel
class AthleteViewModel: ObservableObject {
    
    // List which stores the athletes for the viewModel
    @Published var athletes: [Athlete] = []
    @Published var teams: [String] = []
 
    // My Database
    private var database = Firestore.firestore()
    
    
    // Function which allows me to change a single athlete
    func addAthlete(athlete: Athlete, tournamentName: String) {
        
        // Connects to the database, the specific tournament collection, the document titled TournamentAthletes and adds the athlete
        let _ = database.collection(tournamentName).document("TournamentAthletes").updateData([
            
            // Adds the athlete in the format Name: [Name: name, Team: team, etc.]
            athlete.name: ["Name": athlete.name,
                           "Team": athlete.team,
                           "Age Group": athlete.age_group,
                           "Gender": athlete.gender,
                           "Positions": athlete.positions,
                           "Events": athlete.events,
                           "Times": athlete.times,
                           "Scores": athlete.scores
                            ]
        ])
    }
    
    
    // Function which saves all the athletes which are already in the viewModel
    func save(tournamentName: String) {
        
        
        database.collection("\(tournamentName)").document("TournamentAthletes").delete() { err in
            if let err = err {
                print("Error!!! \(err)")
            } else {
                print("Success")
            }
        }
        
        let _ = database.collection(tournamentName).document("TournamentAthletes").setData([:])
        
        // Going through all the athletes in the viewModel
        for athlete in athletes {
            
            // Calling the above function to add one athlete at a time
            addAthlete(athlete: athlete, tournamentName: tournamentName)
        }
    }
    
    func addTeam(tournamentName: String) {
        
        
        database.collection("\(tournamentName)").document("Details").updateData([
            
            "tournamentTeams": teams
        ])
    }
}
