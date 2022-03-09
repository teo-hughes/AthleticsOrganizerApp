//
//  Athlete.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 16/10/2021.
//


// Imported to access attributes such as DocumentID
import FirebaseFirestoreSwift


// A model for an athlete which is identifiable and codable
struct Athlete: Identifiable, Codable {
    
    // The variables which the athlete will have
    @DocumentID var id: String?
    var name: String
    var age_group: String
    var gender: String
    var team: String
    var positions: [String] = []
    var events: [String] = []
    var times: [Double] = []
    var performances: [Double] = []
    var scores: [Int] = []
    
    // Necessary to allow the athlete to be codable
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case age_group
        case gender
        case team
        case positions
        case events
        case times
        case performances
        case scores
    }
}
