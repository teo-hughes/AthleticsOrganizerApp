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
    @Published var tournament: Tournament = Tournament(name: "", location: "", date: Date(), organizer: User(userName: "", email: "", access: "", tournamentName: ""),Events: [])
    
    // Connecting to the firestore database
    private var database = Firestore.firestore()
    
    
    // Function to add a tournament to firestore
    func addTournament(tournament: Tournament) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        
        
        // To that tournament collection on the details section adds the tournament details
        let _ = database.collection(tournament.name).document("Details").setData([
            "tournamentName" : tournament.name,
            "tournamentLocation": tournament.location,
            "tournamentDate": dateFormatter.string(from: tournament.date),
            "tournamentAgeGroups": tournament.ageGroups,
            "tournamentGenders": tournament.genders,
            "tournamentTeams": tournament.teams,
            "tournamentAccessCode": tournament.accessCode
        ])
        
        
        let _ = database.collection(tournament.name).document("Organizer").setData([
            "OrganizerUserName": tournament.organizer.userName,
            "OrganizerEmail" : tournament.organizer.email,
            "OrganizerAccess" : tournament.organizer.access,
            "OrganizerTournament" : tournament.organizer.tournamentName,
            "OrganizerEvents" : tournament.organizer.eventNames,
            "OrganizerCurrentUser" : tournament.organizer.currentUser
        ])
        
        // To that tournament collection add a TournamentAthletes document which is empty
        let _ = database.collection(tournament.name).document("TournamentAthletes").setData([:])
        
        
        // Add a document for each event with the event details
        for event in tournament.Events {
            let _ = database.collection(tournament.name).document("\(event.event_name)").setData([
                "Name" : event.event_name,
                "Age Groups": event.age_groups,
                "Genders": event.genders,
                "checked": event.checked,
            ])
        }
    }
    
    
    // Function to add the name of the tournament to the current tournament collection
    func addTournamentNames(tournament: Tournament) {
        
        // Adds the tournament.name to the Current Tournaments
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
    
    func addDetails(tournament: Tournament) {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        
        let _ = database.collection("\(tournament.name)").document("Details").setData([
            "tournamentName" : tournament.name,
            "tournamentLocation": tournament.location,
            "tournamentDate": dateFormatter.string(from: tournament.date),
            "tournamentAgeGroups": tournament.ageGroups,
            "tournamentGenders": tournament.genders,
            "tournamentTeams": tournament.teams,
            "tournamentAccessCode": tournament.accessCode

        ])
    }
}
