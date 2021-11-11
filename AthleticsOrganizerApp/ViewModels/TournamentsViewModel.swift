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
                    //print(document.documentID)
                    self.names.append(document.documentID)
                    //print(self.names)
                }

            }

            
        }
    }
    
    func fetchDataFromTournament(tournamentCollectionName: String) {
        
        var events: [Event] = []
        var athletes: [Athlete] = []
        var name: String = ""
        var location: String = ""
        var date: Date = Date()
        
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
                        //print(documentData)
                        name = documentData["tournamentName"] as? String ?? ""
                        location = documentData["tournamentLocation"] as? String ?? ""
                        date = documentData["tournamentdate"] as? Date ?? Date()
                    } else if document.documentID == "TournamentAthletes" {
                        for key in documentData.keys {
                            if let idData = documentData[key] as? [String: Any] {
                                let athleteName = idData["Name"] as? String ?? ""
                                let athleteTeam = idData["Team"] as? String ?? ""
                                let athleteAgeGroup = idData["Age Group"] as? String ?? ""
                                let athleteGender = idData["Gender"] as? String ?? ""
                                athletes.append(Athlete(name: athleteName, age_group: athleteAgeGroup, gender: athleteGender, team: athleteTeam))
                            }
                        }
                    } else {
                        var eventAthletes: [Athlete] = []
                        for key in documentData.keys {
                            if key != "Age Groups" && key != "Athletes" && key != "Genders" && key != "Positions" && key != "Name" && key != "checked" && key != "times" {
                                if let idData = documentData[key] as? [String: Any] {
                                    let eventAthleteName = idData["Name"] as? String ?? ""
                                    let eventAthleteTeam = idData["Team"] as? String ?? ""
                                    let eventAthleteAgeGroup = idData["Age Group"] as? String ?? ""
                                    let eventAthleteGender = idData["Gender"] as? String ?? ""
                                    let eventAthleteTime = idData["Time"] as? Double ?? 0.0
                                    let eventAthletePosition = idData["Position"] as? String ?? ""
                                    let eventAthleteEvent = idData["Event"] as? String ?? ""
                                    eventAthletes.append(Athlete(name: eventAthleteName, age_group: eventAthleteAgeGroup, gender: eventAthleteGender, team: eventAthleteTeam, positions: [eventAthletePosition], events: [eventAthleteEvent], times: [eventAthleteTime]))
                                }
                            }
                        }
                        let tempEvent = Event(event_name: documentData["Name"] as? String ?? "", age_groups: documentData["Age Groups"] as? [String] ?? [""], genders: documentData["Genders"] as? [Bool] ?? [true, true], Athletes: eventAthletes)
                        //print(tempEvent.event_name)
                        events.append(tempEvent)
                        //print(events[0].event_name)
                    }
                }
                
                
                
                let tempTournament = Tournament(name: name, location: location, date: date, Events: events, Athletes: athletes)
                var insideAlready = false
                
                for tournament in self.tournaments {
                    if tempTournament.name == tournament.name {
                        insideAlready = true
                    }
                }
                
                if insideAlready == false {
                    self.tournaments.append(tempTournament)
                }
                //print(self.tournaments)

                
                
            }
        }
    }
    
    func fetchData(tournamentCollectionName: String) {
        
        
        fetchDataFromTournament(tournamentCollectionName: tournamentCollectionName)
        
    }
}



