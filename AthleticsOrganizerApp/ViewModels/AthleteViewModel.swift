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
    
    func addAthlete(athlete: Athlete) {
        
        
        do {
            let _ = try database.collection("Athletes").addDocument(from: athlete)
        }
        catch{
            print("ERROR")
        }
    }
    
    func save() {
        for athlete in athletes {
            addAthlete(athlete: athlete)
        }
    }
}
