//
//  Tournament.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 14/10/2021.
//


// Imported to access attributes such as DocumentID
import FirebaseFirestoreSwift


// A model for the tournament which is identifiable and codable
struct Tournament: Identifiable, Codable {
    
    // The variables which the tournament will have
    @DocumentID var id: String?
    var name: String
    var location: String
    var date: Date
    var ageGroups: [String] = []
    var genders: [Bool] = [false, false]
    var teams: [String] = []
    var accessCode: String = ""
    var organizer: User
    var Events: [Event]
    var Athletes: [Athlete] = []
    
    // Necessary to allow the tournament to be codable
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case location
        case date
        case ageGroups
        case genders
        case teams
        case accessCode
        case organizer
        case Events
        case Athletes
    }
}
