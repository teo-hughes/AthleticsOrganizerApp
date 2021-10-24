//
//  AthleteViewModel.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 23/10/2021.
//

import Foundation
import FirebaseFirestore

class AthleteViewModel: ObservableObject {
    
    
    
    @Published var athletes: [Athlete] = []
    
    private var database = Firestore.firestore()
    
    func addAthlete(athlete: Athlete, tournamentName: String) {
        
        
        
        let ref = database.collection(tournamentName).document("TournamentAthletes")
            
        ref.updateData([
            "Athletestest": FieldValue.arrayUnion(["Tests"])
        ])

    }
    
    func save(tournamentName: String) {
        for athlete in athletes {
            addAthlete(athlete: athlete, tournamentName: tournamentName)
        }
    }
}
