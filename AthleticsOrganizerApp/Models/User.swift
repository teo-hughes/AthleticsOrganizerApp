//
//  User.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 27/11/2021.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    
    @DocumentID var id: String?
    var username: String
    var access: String
    var currentUser: Bool = false
    var tournamentName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case access
        case currentUser
        case tournamentName
    }
    
}
