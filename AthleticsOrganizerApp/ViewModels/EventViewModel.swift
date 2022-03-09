//
//  EventViewModel.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 16/10/2021.
//


// Importing FirebaseFirestore to connect to Firestore
import FirebaseFirestore


// The viewModel of the EventView
class EventViewModel: ObservableObject {
    
    
    // List which will be added with all the possibleEvents
    @Published var possibleEvents = [Event]()
    
    // Connecting to the firestore database
    private var database = Firestore.firestore()
    
    // All the possible events
    private var EventNames : [String] = [
        "100 metres",
        "200 metres",
        "400 metres",
        "800 metres",
        "1500 metres",
        "3000 metres",
        "5000 metres",
        "10,000 metres",
        "110 metres hurdles",
        "400 metres hurdles",
        "2000 metres steeplechase",
        "3000 metres steeplechase",
        "4x100 metres relay",
        "4x400 metres relay",
        "High jump",
        "Pole Vault",
        "Long jump",
        "Triple jump",
        "Shot put",
        "Discus throw",
        "Hammer throw",
        "Javelin throw",
        "Decathlon"
    ]
    
    private var NationalRecords : [Double] = [10.21, 20.54, 45.36, 105.64, 216.6, 468.28, 807.04, 1761.9, 13.44, 50.22, 329.61, 509.85, 39.21, 183.8, 2.37, 5.5, 7.98, 16.58, 18.11, 55.1, 67.48, 79.5, 8082]
    
    private var NationalStandards : [Double] = [10.9, 22.0, 48.8, 113.0, 235.0, 513.0, 890.0, 1920.0, 14.7, 55.0, 364.0, 587.0, 43.5, 196.0, 2.0, 4.4, 6.9, 14.4, 14.1, 46.0, 52.0, 57.0, 6000]
    
    private var EntryStandards : [Double] = [11.1, 22.3, 49.3, 115.0, 238.0, 516.0, 904.0, 1960.0, 15.2, 56.5, 370.0, 601.0, 44.5, 203.0, 1.94, 4.1, 6.8, 13.9, 13.0, 40.0, 46.0, 53.0, 5500]
    
    private var CountyStandards : [Double] = [11.5, 23.3, 52.5, 162.0, 255.0, 560.0, 932.0, 2003.0, 16.2, 59.5, 390.0, 662.0, 45.3, 220.0, 1.83, 3.3, 6.25, 12.85, 11.5, 34.0, 39.0, 46.0, 5000]
    
    // Function to update an Event in firestore
    func saveEvent(tournamentName: String, event: Event) {
        
        // Adding athletes
        for athlete in event.Athletes {
            
            // Find the index of the event in athlete.events
            let index = athlete.events.firstIndex(of: event.event_name) ?? 0
            
            // Add the athlete to the event in the specific tournament
            let _ = database.collection(tournamentName).document("\(event.event_name)").updateData([
                athlete.name: ["Name": athlete.name, "Age Group": athlete.age_group, "Gender": athlete.gender, "Team": athlete.team, "Event": athlete.events[index], "Position": athlete.positions[index], "Time": athlete.times[index], "Performance": athlete.performances[index], "Score": athlete.scores[index]]
            ])
        }
    }
    
    
    // Function to update/add a single athlete to a specific event
    func saveAthlete(tournamentName: String, event: Event, athlete: Athlete) {
        
        // Find the index of the event in athlete.events
        let index = athlete.events.firstIndex(of: event.event_name) ?? 0
        
        // Add the athlete to the event in the specific tournament
        let _ = database.collection(tournamentName).document("\(event.event_name)").updateData([
            athlete.name: ["Name": athlete.name, "Age Group": athlete.age_group, "Gender": athlete.gender, "Team": athlete.team, "Event": athlete.events[index], "Position": athlete.positions[index], "Time": athlete.times[index], "Performance": athlete.performances[index], "Score": athlete.scores[index]]
        ])
    }
    
    
    // What happens when you initialize the viewModel
    init() {
        
        // Add the possibleEvents to the list
        for n in 0..<EventNames.count {
            possibleEvents.append(Event(event_name: EventNames[n], age_groups: [], genders: [], NR: NationalRecords[n], NS: NationalStandards[n], ES: EntryStandards[n], CS: CountyStandards[n]))
        }
    }
}
