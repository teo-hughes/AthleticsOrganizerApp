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
        
        /*database.collection("Tournaments").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let dt = document.data()
                    self.tournaments.append(Tournament(id: document.documentID, name: dt["name"] as! String, location: dt["location"] as! String, date: dt["date"] as! String, allEvents: dt["allEvents"] as! String, open: (dt["open"] != nil)))
                }
            }
            
        }*/
        database.collection("Tournaments").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            /*self.tournaments = documents.map { (queryDocumentSnapshot) -> Tournament in
                let data = queryDocumentSnapshot.data()
                
                let name = data["name"] as? String ?? ""
                print(name)
                let location = data["location"] as? String ?? ""
                let date = data["date"] as? String ?? ""
                let allEvents = data["AllEvents"] as? String ?? ""
                
                return Tournament(name: name, location: location, date: date, allEvents: allEvents)

            }*/
            
            self.tournaments = documents.compactMap { queryDocumentSnapshot in
                try? queryDocumentSnapshot.data(as: Tournament.self)
            }
        }
        
        
    }
}
