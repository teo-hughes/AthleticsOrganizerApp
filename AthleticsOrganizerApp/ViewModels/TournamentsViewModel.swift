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
    @Published var names = [String]()
    //var tempTournaments: [Tournament] = []
    
    private var database = Firestore.firestore()
    
    func fetchTournamentNames() {
        
        //self.names = []
        database.collection("Current Tournaments").getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("ERROR \(err)")
            } else {
                self.names = []
                for document in querySnapshot!.documents {
                    print(document.documentID)
                    self.names.append(document.documentID)
                    print(self.names)
                }

            }

            
        }
    }
    
    func fetchDataFromTournament(tournamentCollectionName: String) {
        
        var events: [Event] = []
        var name: String = ""
        var location: String = ""
        var date: Date = Date.now
        
        database.collection(tournamentCollectionName).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("ERROR \(err)")
            } else {
                //self.tournaments = []
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    let documentData = document.data()
                    //events = []

                    if document.documentID == "Details" {
                        name = documentData["tournamentName"] as? String ?? ""
                        location = documentData["tournamentLocation"] as? String ?? ""
                        date = documentData["tournamentdate"] as? Date ?? Date.now
                    } else {
                        let tempEvent = Event(event_name: documentData["Name"] as? String ?? "", age_groups: documentData["Age Groups"] as? [String] ?? [""], genders: documentData["Genders"] as? [Bool] ?? [true, true])
                        //print(tempEvent.event_name)
                        events.append(tempEvent)
                        //print(events[0].event_name)
                    }
                }
                
                
                
                let tempTournament = Tournament(name: name, location: location, date: date, Events: events)
                var insideAlready = false
                
                for tournament in self.tournaments {
                    if tempTournament.name == tournament.name {
                        insideAlready = true
                    }
                }
                
                if insideAlready == false {
                    self.tournaments.append(tempTournament)
                }
                print(self.tournaments)

                
                
            }
        }
    }
    
    func fetchData(tournamentCollectionName: String) {
        
        /*self.names = []
        fetchTournamentNames()

        print(self.names)
        for name in self.names {
            print(name)
            fetchDataFromTournament(tournamentCollectionName: name)
        }*/
        
        fetchDataFromTournament(tournamentCollectionName: tournamentCollectionName)
        
        
        
        
        
        
    }
}

/*database.collection("NEW TOURNAMENT").addSnapshotListener { querySnapshot, error in
    guard let documents = querySnapshot?.documents else {
        print("No documents")
        return
    }
    
    self.tournaments = documents.compactMap { (queryDocumentSnapshot) -> Tournament in
        
        let data = queryDocumentSnapshot.data()
        
        let name = data["tournamentName"] as? String ?? ""
        let location = data["tournamentLocation"] as? String ?? ""
        let date = data["tournamentdate"] as? Date ?? Date.now
        
        let tournament = Tournament(name: name, location: location, date: date, Events: [])
        return tournament
    }
}*/


/*
database.collection("Second Tournament").getDocuments() { (querySnapshot, err) in
    if let err = err {
        print("ERROR \(err)")
    } else {
        for document in querySnapshot!.documents {
            print("\(document.documentID) => \(document.data())")
            let documentData = document.data()
            events = []

            if document.documentID == "Details" {
                name = documentData["tournamentName"] as? String ?? ""
                location = documentData["tournamentLocation"] as? String ?? ""
                date = documentData["tournamentdate"] as? Date ?? Date.now
            } else {
                events.append(Event(event_name: documentData["Name"] as? String ?? "", age_groups: documentData["Age Groups"] as? [String] ?? [""], genders: documentData["Genders"] as? [Bool] ?? [true, true]))
            }
        }
        
        self.tournaments.append(Tournament(name: name, location: location, date: date, Events: events))
    }
}
*/
