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
    var location: String
    var date: String
    var allEvents: String
    var open: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case location
        case date
        case allEvents
        case open
    }
}

