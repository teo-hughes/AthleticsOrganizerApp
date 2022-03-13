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
 
    // Accessing the database
    private var database = Firestore.firestore()
    
    
    // Function which allows me to change a single athlete
    func addAthlete(athlete: Athlete, tournamentName: String) {
        
        // Connects to the database, the specific tournament collection, the document titled TournamentAthletes and adds the athlete
        let _ = database.collection(tournamentName).document("TournamentAthletes").updateData([
            
            // Adds the athlete in the format Name: [Name: name, Team: team, etc.]
            athlete.name: ["Name": athlete.name,
                           "Team": athlete.team,
                           "Age Group": athlete.age_group,
                           "Gender": athlete.gender]
        ])
    }
    
    
    // Function which saves all the athletes which are already in the viewModel
    func save(tournamentName: String) {
        
        // Delete all the athletes in tournament athletes
        database.collection("\(tournamentName)").document("TournamentAthletes").delete() { err in
            
            // Checks for errors
            if let err = err {
                print("Error!!! \(err)")
            } else {
                print("Success")
            }
        }
        
        // Set the data in the TournamentAthletes document to nothing
        let _ = database.collection(tournamentName).document("TournamentAthletes").setData([:])
        
        // Going through all the athletes in the viewModel
        for athlete in athletes {
            
            // Calling the above function to add one athlete at a time
            addAthlete(athlete: athlete, tournamentName: tournamentName)
        }
    }
    
    
    // Function which adds the teams to the view model
    func addTeam(tournamentName: String) {
        
        // Access the details document in the tournament and update the teams field
        database.collection("\(tournamentName)").document("Details").updateData([
            "tournamentTeams": teams
        ])
    }
}
