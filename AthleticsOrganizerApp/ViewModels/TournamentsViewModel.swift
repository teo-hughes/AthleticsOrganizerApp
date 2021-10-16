//
//  TournamentsViewModel.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 16/10/2021.
//

import Foundation
import FirebaseFirestore

class TournamentsViewModel: ObservableObject {
    @Published var tournaments = [Tournament]()
    
    private var database = Firestore.firestore()
    
    func fetchData() {
        database.collection("Tournaments").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.tournaments = documents.map { (queryDocumentSnapshot) -> Tournament in
                let data = queryDocumentSnapshot.data()
                
                let name = data["name"] as? String ?? ""
                let location = data["location"] as? String ?? ""
                let date = data["date"] as? String ?? ""
                let allEvents = data["AllEvents"] as? String ?? ""
                
                return Tournament(name: name, location: location, date: date, allEvents: allEvents)

            }
        }
    }
}
