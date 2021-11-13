//
//  TournamentViewModel.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 08/10/2021.
//

import FirebaseFirestore

// The View Model of the TournamentView
class TournamentViewModel: ObservableObject {
    
    
    @Published var tournament: Tournament = Tournament(name: "", location: "", date: Date(), Events: [])
    
    private var database = Firestore.firestore()
    
    func addTournament(tournament: Tournament) {
        
        
        let _ = database.collection(tournament.name).document("Details").setData([
            "tournamentName" : tournament.name,
            "tournamentLocation": tournament.location,
            "tournamentdate": tournament.date
        ])
        
        let _ = database.collection(tournament.name).document("TournamentAthletes").setData([:])
        
        for event in tournament.Events {
            let _ = database.collection(tournament.name).document("\(event.event_name)").setData([
                "Name" : event.event_name,
                "Age Groups": event.age_groups,
                "Genders": event.genders,
                "checked": event.checked,
            ])
        }
        
        
    }
    
    func addTournamentNames(tournament: Tournament) {
        
        
        
        let _ = database.collection("Current Tournaments").document("\(tournament.name)").setData([
            "tournamentName" : tournament.name
        ])
        
        
    }
    
    func save() {
        addTournament(tournament: tournament)
        addTournamentNames(tournament: tournament)
    }
}
