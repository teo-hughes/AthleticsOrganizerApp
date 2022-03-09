//
//  Event.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 16/10/2021.
//


// Imported to access attributes such as DocumentID
import FirebaseFirestoreSwift


// A model for an event which is identifiable and codable
struct Event: Identifiable, Codable {
    
    // The variables which the event will have
    @DocumentID var id: String?
    var event_name: String
    var age_groups: [String]
    var genders: [Bool]
    var Athletes: [Athlete] = []
    var NR: Float
    var NS: Float
    var ES: Float
    var CS: Float
    var checked: Bool = false
    
    // Necessary to allow the event to be codable
    enum CodingKeys: String, CodingKey {
        case id
        case event_name
        case age_groups
        case genders
        case Athletes
        case NR
        case NS
        case ES
        case CS
        case checked
    }
}
