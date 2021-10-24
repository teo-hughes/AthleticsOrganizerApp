//
//  Tournament.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 14/10/2021.
//


// Installed Firebase
import FirebaseFirestoreSwift

// Tournament with it's data
struct Tournament: Identifiable, Codable {
    
    // ID and its other variables
    @DocumentID var id: String?
    var name: String
    var location: String
    var date: Date
    var Events: [Event]
    var Athletes: [Athlete] = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case location
        case date
        case Events
        case Athletes
    }
}

