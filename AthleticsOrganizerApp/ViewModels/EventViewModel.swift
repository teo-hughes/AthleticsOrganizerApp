//
//  EventViewModel.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 16/10/2021.
//

import Foundation
import FirebaseFirestore

class EventViewModel: ObservableObject {
    @Published var possibleEvents = [Event]()
    
    private var database = Firestore.firestore()
    
    private var EventNames : [String] = [
        "60 metres",
        "100 metres",
        "200 metres",
        "400 metres",
        "800 metres",
        "1500 metres",
        "3000 metres",
        "5000 metres",
        "10,000 metres",
        "60 metres hurdles",
        "100 metres hurdles",
        "110 metres hurdles",
        "400 metres hurdles",
        "3000 metres steeplechase",
        "Half marathon (road)",
        "Marathon (road)",
        "20 kilometres race walk (road)",
        "50 kilometres race walk (road)",
        "Cross country running",
        "4x100 metres relay",
        "4x400 metres relay",
        "Mixed 4x400 metres relay",
        "Pole vault",
        "High jump",
        "Long jump",
        "Triple jump",
        "Shot put",
        "Discus throw",
        "Hammer throw",
        "Javelin throw",
        "Pentathlon",
        "Heptathlon",
        "Decathlon"
    ]
    
    func saveEvent(tournamentName: String, event: Event) {
        
        for athlete in event.Athletes {
            
            let index = athlete.events.firstIndex(of: event.event_name) ?? 0
            
            let _ = database.collection(tournamentName).document("\(event.event_name)").updateData([
                athlete.name: ["Name": athlete.name, "Age Group": athlete.age_group, "Gender": athlete.gender, "Team": athlete.team, "Event": athlete.events[index], "Position": athlete.positions[index], "Time": athlete.times[index]]
            ])
        }
    }
    
    init() {
        for eventName in EventNames {
            possibleEvents.append(Event(event_name: eventName, age_groups: [], genders: []))
        }
    }
}
