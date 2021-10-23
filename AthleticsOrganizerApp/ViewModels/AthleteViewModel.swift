//
//  AthleteViewModel.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 23/10/2021.
//

import Foundation
import FirebaseFirestore

class AthleteViewModel: ObservableObject {
    
    
    @Published var athlete: Athlete = Athlete(name: "", age_group: "", gender: "", team: "")
    
    private var database = Firestore.firestore()
    
    func addAthlete(athlete: Athlete) {
        
        do {
            let _ = try database.collection("Athletes").addDocument(from: athlete)
        }
        catch{
            print("ERROR")
        }
    }
    
    func save() {
        addAthlete(athlete: athlete)
    }
}
