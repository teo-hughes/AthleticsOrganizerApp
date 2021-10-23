//
//  Event.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 16/10/2021.
//

import FirebaseFirestoreSwift


struct Event: Identifiable, Codable {
    
    // ID and its other variables
    @DocumentID var id: String?
    var event_name: String
    var age_groups: [String]
    var genders: [Bool]
    var positions: [Int] = []
    var athletes: [String] = []
    var times: [Double] = []
    var checked: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case event_name
        case age_groups
        case genders
        case positions
        case athletes
        case times
        case checked
    }
}
