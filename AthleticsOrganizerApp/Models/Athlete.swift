//
//  Athlete.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 16/10/2021.
//

import FirebaseFirestoreSwift


struct Athlete: Identifiable, Codable {
    
    // ID and its other variables
    @DocumentID var id: String?
    var name: String
    var age_group: String
    var gender: String
    var open: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case age_group
        case gender
        case open
    }
}
