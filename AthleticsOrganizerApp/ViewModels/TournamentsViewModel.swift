//
//  TournamentsViewModel.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 16/10/2021.
//


// Importing FirebaseFirestore to connect to Firestore
import FirebaseFirestore


// The viewModel of the tournaments (to collect from firestore)
class TournamentsViewModel: ObservableObject {
    
    
    // Variables which will collect the tournaments and tournament names
    @Published var tournaments = [Tournament]()
    @Published var names = [String]()
    
    // Connect to the Firestore database
    private var database = Firestore.firestore()
    
    
    // Function to fetch the names of all the tournaments
    func fetchTournamentNames() {
        
        // Collect the names from current Tournaments
        database.collection("Current Tournaments").addSnapshotListener { (querySnapshot, err) in
            
            // Guard against errors
            if let err = err {
                print("ERROR \(err)")
            } else {
                
                // For each document in current tournaments add the name of the document to self.names
                self.names = []
                for document in querySnapshot!.documents {
                    self.names.append(document.documentID)
                }
            }
        }
    }
    
    
    // Function to fetch all the data from a specific tournament and add to tournaments
    func fetchDataFromTournament(tournamentCollectionName: String) {
        
        // Initial variables to store the data
        var events: [Event] = []
        var athletes: [Athlete] = []
        var name: String = ""
        var location: String = ""
        var date: String = ""
        var ageGroups: [String] = [""]
        var genders: [Bool] = [false, false]
        var teams: [String] = [""]
        var accessCode: String = ""
        var organizer: User = User(userName: "", email: "", access: "", tournamentName: "", eventNames: [])
        
        
        // Open the tournament collection
        database.collection(tournamentCollectionName).addSnapshotListener { (querySnapshot, err) in
            
            // Guard against errors
            if let err = err {
                print("ERROR \(err)")
            } else {
                
                // Go through all the documents
                for document in querySnapshot!.documents {
                    
                    // Store the data in a variable called documentData
                    let documentData = document.data()
                    
                    // If the document contains the details of the tournament
                    if document.documentID == "Details" {
                        
                        // Fetch the name, location and date
                        name = documentData["tournamentName"] as? String ?? ""
                        location = documentData["tournamentLocation"] as? String ?? ""
                        date = documentData["tournamentDate"] as? String ?? ""
                        ageGroups = documentData["tournamentAgeGroups"] as? [String] ?? [""]
                        genders = documentData["tournamentGenders"] as? [Bool] ?? [false, false]
                        teams = documentData["tournamentTeams"] as? [String] ?? [""]
                        accessCode = documentData["tournamentAccessCode"] as? String ?? ""
                        
                        // If the document contains the athlete
                    } else if document.documentID == "Organizer" {
                        
                        organizer.userName = documentData["OrganizerUserName"] as? String ?? ""
                        organizer.email = documentData["OrganizerEmail"] as? String ?? ""
                        organizer.access = documentData["OrganizerAccess"] as? String ?? ""
                        organizer.eventNames = documentData["OrganizerEvents"] as? [String] ?? []
                        organizer.tournamentName = documentData["OrganizerTournament"] as? String ?? ""
                        organizer.currentUser = documentData["OrganizerCurrentUser"] as? Bool ?? true
                        
                    } else if document.documentID == "TournamentAthletes" {
                        
                        // Go through the keys of the document (in this case the names of the athletes)
                        for key in documentData.keys {
                            
                            // Create idData allowing you to fetch data for each athlete
                            if let idData = documentData[key] as? [String: Any] {
                                
                                // Fetch the athlete details
                                let athleteName = idData["Name"] as? String ?? ""
                                let athleteTeam = idData["Team"] as? String ?? ""
                                let athleteAgeGroup = idData["Age Group"] as? String ?? ""
                                let athleteGender = idData["Gender"] as? String ?? ""
                                
                                // Add an Athlete created with the athlete details to athletes
                                athletes.append(Athlete(name: athleteName, age_group: athleteAgeGroup, gender: athleteGender, team: athleteTeam))
                            }
                        }
                        
                        // If the document is an event
                    } else {
                        
                        // Create a variable to store the eventAthletes
                        var eventAthletes: [Athlete] = []
                        
                        // Go through all the keys inside the event
                        for key in documentData.keys {
                            
                            // If the key is an athlete
                            if key != "Age Groups" && key != "Athletes" && key != "Genders" && key != "Positions" && key != "Name" && key != "checked" && key != "times" {
                                
                                // Create idData allowing you to fetch data for each athlete
                                if let idData = documentData[key] as? [String: Any] {
                                    
                                    // Fetch the athlete details
                                    let eventAthleteName = idData["Name"] as? String ?? ""
                                    let eventAthleteTeam = idData["Team"] as? String ?? ""
                                    let eventAthleteAgeGroup = idData["Age Group"] as? String ?? ""
                                    let eventAthleteGender = idData["Gender"] as? String ?? ""
                                    let eventAthleteTime = idData["Time"] as? Double ?? 0.0
                                    let eventAthletePosition = idData["Position"] as? String ?? ""
                                    let eventAthleteEvent = idData["Event"] as? String ?? ""
                                    
                                    // Add an Athlete created with the athlete details to eventAthletes
                                    eventAthletes.append(Athlete(name: eventAthleteName, age_group: eventAthleteAgeGroup, gender: eventAthleteGender, team: eventAthleteTeam, positions: [eventAthletePosition], events: [eventAthleteEvent], times: [eventAthleteTime]))
                                }
                            }
                        }
                        
                        // Create an Event with all the data you have collected
                        let tempEvent = Event(event_name: documentData["Name"] as? String ?? "", age_groups: documentData["Age Groups"] as? [String] ?? [""], genders: documentData["Genders"] as? [Bool] ?? [true, true], Athletes: eventAthletes)
                        
                        // Add the tempEvent to events
                        events.append(tempEvent)
                    }
                }
                
                
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "HH:mm E, d MMM y"
                let dateDate = dateFormatter.date(from: date) ?? Date()
                // Create a tournamnet with all the details fetched from firestore
                let tempTournament = Tournament(name: name, location: location, date: dateDate, ageGroups: ageGroups, genders: genders, teams: teams, accessCode: accessCode, organizer: organizer, Events: events, Athletes: athletes)
                
                // Check if you have already fetched the tournaments
                var insideAlready = false
                for tournament in self.tournaments {
                    if tempTournament.name == tournament.name {
                        insideAlready = true
                    }
                }
                
                // If you haven't already fetched the tournament, add it to self.tournaments
                if insideAlready == false {
                    self.tournaments.append(tempTournament)
                }
                
            }
        
            
        }
    }
    
    
    // Function which will be called to fetch the data from a tournamnet
    func fetchData(tournamentCollectionName: String) {
        
        // Call the function which fetches all the data
        fetchDataFromTournament(tournamentCollectionName: tournamentCollectionName)
    }
    
    func deleteTournament(tournamentName: String) {
        database.collection("Current Tournaments").document("\(tournamentName)").delete() { err in
            if let err = err {
                print("Error!!! \(err)")
            } else {
                self.database.collection("\(tournamentName)").getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error!!! \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                                self.database.collection("\(tournamentName)").document(document.documentID).delete() { err in
                                    if let err = err {
                                        print("Error!!! \(err)")
                                    }
                                    
                                }
                            }
                        }
                }
            }
        }
    }
    
    func fetch() {
        fetchTournamentNames()
        for name in self.names {
            fetchData(tournamentCollectionName: name)
        }
    }
}
