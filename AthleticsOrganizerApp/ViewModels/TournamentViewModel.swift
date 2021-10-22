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
            let _ = try database.collection("Tournaments").addDocument(from: tournament)
        }
        catch{
            print("ERROR")
        }
    }
    
    func save() {
        addTournament(tournament: tournament)
    }
}
