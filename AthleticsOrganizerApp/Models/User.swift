//
//  User.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 27/11/2021.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    
    @DocumentID var id: String?
    var userName: String
    var email: String
    var access: String
    var tournamentName: String
    var currentUser: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case userName
        case email
        case access
        case tournamentName
        case currentUser
    }
    
}
