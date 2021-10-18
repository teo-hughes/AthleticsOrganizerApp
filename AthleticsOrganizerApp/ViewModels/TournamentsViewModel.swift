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
        

        database.collection("Tournaments").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.tournaments = documents.compactMap { queryDocumentSnapshot in
                try? queryDocumentSnapshot.data(as: Tournament.self)
            }
        }
        
        
    }
}
