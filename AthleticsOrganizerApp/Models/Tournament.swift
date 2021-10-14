//
//  Tournament.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 14/10/2021.
//


// Installed Firebase
import FirebaseFirestore

// Tournament with it's data
struct Tournament: Identifiable, Codable {
    
    // ID and its other variables
    var id = UUID()
    var location: String
    var date: Date
    var open: Bool = false
}
