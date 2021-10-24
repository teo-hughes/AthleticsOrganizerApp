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
        
        
        
        /*let ref = database.collection(tournamentName).document("TournamentAthletes")
            
        ref.updateData([
            "Athletestest": FieldValue.arrayUnion(["Tests"])
        ])*/

        
        let _ = database.collection(tournamentName).document("TournamentAthletes").updateData([
            //"Tournament Athletes": FieldValue.arrayUnion(["Name": athlete.name, "Team": athlete.team, "Age Group": athlete.age_group, "Gender": athlete.gender])
            "Tournament Athletes": FieldValue.arrayUnion([athlete.name])
        ])
    }
    
    func save(tournamentName: String) {
        for athlete in athletes {
            addAthlete(athlete: athlete, tournamentName: tournamentName)
        }
    }
}
