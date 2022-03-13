//
//  TournamentViewModel.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 08/10/2021.
//


// Importing FirebaseFirestore to connect to Firestore
import FirebaseFirestore


// The View Model of the TournamentView
class TournamentViewModel: ObservableObject {
    
    
    //Variable which stores a single tournament
    @Published var tournament: Tournament = Tournament(name: "", location: "", date: Date(), Events: [])
    
    // Connecting to the firestore database
    private var database = Firestore.firestore()
    
    
    // Function to add a tournament to firestore
    func addTournament(tournament: Tournament) {
        
        // Create a date formatter to turn the date into a string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        
        // Adds the details of the tournament into firebase
        let _ = database.collection(tournament.name).document("Details").setData([
            "tournamentName" : tournament.name,
            "tournamentLocation": tournament.location,
            "tournamentDate": dateFormatter.string(from: tournament.date),
            "tournamentAgeGroups": tournament.ageGroups,
            "tournamentGenders": tournament.genders,
            "tournamentTeams": tournament.teams
        ])
        
        // Creates an empty tournament athletes document
        let _ = database.collection(tournament.name).document("TournamentAthletes").setData([:])
        
        // Go through all the events in the tournament
        for event in tournament.Events {
            
            // Add the attributes of the event into firebase
            let _ = database.collection(tournament.name).document("\(event.event_name)").setData([
                "Name" : event.event_name,
                "Age Groups": event.age_groups,
                "Genders": event.genders,
                "National Record": event.NR,
                "National Standard": event.NS,
                "Entry Standard": event.ES,
                "County Standard": event.CS,
                "checked": event.checked,
            ])
        }
    }
    
    
    // Function to add the name of the tournament to the current tournament collection
    func addTournamentNames(tournament: Tournament) {
        
        // Adds the tournament.name to the Current Tournaments collection
        let _ = database.collection("Current Tournaments").document("\(tournament.name)").setData([
            "tournamentName" : tournament.name
        ])
    }
    
    
    // Function to add the tournament to firestore and then add the name to Current Tournaments
    func save() {
        
        // Add tournament to Firestore
        addTournament(tournament: tournament)
        
        // Add tournament name to Current Tournaments
        addTournamentNames(tournament: tournament)
    }
    
    // Function to add the details of the tournament to firebase
    func addDetails(tournament: Tournament) {
        
        // Create a date formatter to turn the date into a string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        
        // Store the details of the tournament into firebase
        let _ = database.collection("\(tournament.name)").document("Details").setData([
            "tournamentName" : tournament.name,
            "tournamentLocation": tournament.location,
            "tournamentDate": dateFormatter.string(from: tournament.date),
            "tournamentAgeGroups": tournament.ageGroups,
            "tournamentGenders": tournament.genders,
            "tournamentTeams": tournament.teams
        ])
    }
}
