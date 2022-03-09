//
//  User.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 27/11/2021.
//


// Imported to access attributes such as DocumentID
import FirebaseFirestoreSwift


// A model for a user which is identifiable and codable
struct User: Identifiable, Codable {
    
    // The variables which the user will have
    @DocumentID var id: String?
    var userName: String
    var email: String
    var access: String
    var tournamentName: String
    var eventNames: [String]
    var currentUser: Bool = false
    
    // Necessary to allow the user to be codable
    enum CodingKeys: String, CodingKey {
        case id
        case userName
        case email
        case access
        case tournamentName
        case eventNames
        case currentUser
    }
}
