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
        
        
        do {
            let ref = try database.collection(tournamentName).document("TournamentAthletes")
            
            ref.updateData([
                "Athletestest": FieldValue.arrayUnion(["Tests"])
            ])
        }
        catch{
            print("ERROR")
        }
    }
    
    func save(tournamentName: String) {
        for athlete in athletes {
            addAthlete(athlete: athlete, tournamentName: tournamentName)
        }
    }
}
