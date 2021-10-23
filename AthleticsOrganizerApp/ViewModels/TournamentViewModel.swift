//
//  TournamentViewModel.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 08/10/2021.
//

import Foundation
import FirebaseFirestore

// The View Model of the TournamentView
class TournamentViewModel: ObservableObject {
    
    
    @Published var tournament: Tournament = Tournament(name: "", location: "", date: Date(), Events: [])
    
    private var database = Firestore.firestore()
    
    func addTournament(tournament: Tournament) {
        
        do {
            let _ = try database.collection(tournament.name).document("Details").setData([
                "tournamentName" : tournament.name,
                "tournamentLocation": tournament.location,
                "tournamentdate": tournament.date
            ])
            
            for event in tournament.Events {
                let _ = try database.collection(tournament.name).document("\(event.event_name)").setData([
                    "Name" : event.event_name,
                    "Age Groups": event.age_groups,
                    "Genders": event.genders,
                    "Positions": event.positions,
                    "times": event.times,
                    "checked": event.checked,
                    "Athletes": event.Athletes
                ])
            }
        }
        catch{
            print("ERROR")
        }
        
    }
    
    func addTournamentNames(tournament: Tournament) {
        
        
        do {
            let _ = try database.collection("Current Tournaments").document("\(tournament.name)").setData([
                "tournamentName" : tournament.name
            ])
        }
        catch{
            print("ERROR")
        }
    }
    
    func save() {
        addTournament(tournament: tournament)
        addTournamentNames(tournament: tournament)
    }
}
