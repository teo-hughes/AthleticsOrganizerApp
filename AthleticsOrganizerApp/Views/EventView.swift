//
//  EventView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 18/10/2021.
//


// Importing SwiftUI
import SwiftUI


// This view is what is shown when an event is pressed
struct EventView: View {
    
    // Fetch the event, athletes and name as parameters
    @State var event: Event
    @State var tournamentAthletes: [Athlete]
    @State var tournamentName: String
    
    // To show the sheets to add athletes to the event or add times to the event
    @State private var presentAddAthletesScreen = false
    @State private var presentAddTimesScreen = false
    
    // Variables which allows us to display different age groups and/or genders for the event
    @State private var chosenGender: String = "Female"
    @State private var chosenAgeGroup: String = ""
    @State private var genderExpand: Bool = false
    @State private var ageGroupExpand: Bool = false
    
    // The times and positions of the event
    @State private var times : [Double] = []
    @State private var positions: [Int] = []
    
    
    // The body of the EventView
    var body: some View {
        
        
        // VStack to structure the UI
        VStack {
            
            // HStack for the top to show the age group and gender
            HStack {
                
                
                // VStack for the gender
                VStack(spacing: 10) {
                    
                    // HStack which shows the chosenGender and a dropdown button
                    HStack {
                        
                        // UI of text
                        Text(chosenGender)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        // Dropdown button
                        Image(systemName: genderExpand ? "chevron.up": "chevron.down")
                            .resizable().frame(width: 13, height: 6)
                            .foregroundColor(.black)
                        
                        // When the HStack is tapped
                    }.onTapGesture {
                        
                        // Toggle the genderExpand
                        self.genderExpand.toggle()
                    }
                    
                    // If the genderExpand is true
                    if genderExpand {
                        
                        // If there is a male option for the event
                        if event.genders[0] {
                            
                            // A button which when pressed changes the gender of the chosen event
                            Button(action: {
                                
                                // Toggle genderExpand and change chosenGender to male
                                self.genderExpand.toggle()
                                chosenGender = "Male"
                            }, label: {
                                
                                // UI of button
                                Text("Male")
                                    .padding()
                                    .foregroundColor(.black)
                            })
                        }
                        
                        // If there is a female option for the event
                        if event.genders[1] {
                            
                            // A button which when pressed changes the gender of the chosen event
                            Button(action: {
                                
                                // Toggle genderExpand and change chosenGender to female
                                self.genderExpand.toggle()
                                chosenGender = "Female"
                            }, label: {
                                
                                // UI of button
                                Text("Female")
                                    .padding()
                                    .foregroundColor(.black)
                            })
                        }
                    }
                }
                .padding()
                
                // Spacer to move the gender VStack as far left as possible
                Spacer()
                
                
                // VStack for the age group
                VStack(spacing: 10) {
                    
                    // HStack which shows the chosenAgeGroup and a dropdown button
                    HStack {
                        
                        // UI of text
                        Text(chosenAgeGroup)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        // Dropdown button
                        Image(systemName: ageGroupExpand ? "chevron.up": "chevron.down")
                            .resizable().frame(width: 13, height: 6)
                            .foregroundColor(.black)
                        
                        // When the HStack is tapped
                    }.onTapGesture {
                        
                        // Toggle the ageGroupExpand
                        self.ageGroupExpand.toggle()
                    }
                    
                    // If ageGroupExpand is true
                    if ageGroupExpand {
                        
                        // For each age group in the event
                        ForEach(event.age_groups, id: \.self) { ageGroup in
                            
                            // A button which when pressed changes the age group of chosenAgeGroup
                            Button(action: {
                                
                                // Toggle ageGroupExpand and change the chosenAgeGroup
                                self.ageGroupExpand.toggle()
                                chosenAgeGroup = ageGroup
                            }, label: {
                                
                                // UI of button
                                Text(ageGroup)
                                    .padding()
                                    .foregroundColor(.black)
                            })
                        }
                    }
                }
            }
            .padding()
            
            
            // Button to add athletes for the event
            Text("Add Athletes For Event")
            
            // When the button is pressed it toggles presentAddAthletesScreen
            Button(action: {
                presentAddAthletesScreen.toggle()
            }, label: {
                
                // Shows a +
                Image(systemName: "plus")
                    .font(.system(size: 25))
            })
            // Shows the SearchAthletesView if the presentAddAthletesScreen is true
            .sheet(isPresented: $presentAddAthletesScreen) {
                SearchAthletesView(event: event, tournamentAthletes: tournamentAthletes, chosenAgeGroup: chosenAgeGroup, chosenGender: chosenGender, tournamentName: tournamentName)
            }
            
            // Spacer to send the button and HStack to the top
            Spacer()
            
            
            // UI to show top bar of the positions table
            Text(event.event_name)
            HStack {
                Text("Position")
                Text("Name")
                Text("Team")
                Text("Time")
                Text("Performance")
                Text("Score")
            }
            
            // For each of the positions
            ForEach(positions, id: \.self) { n in
                
                // Find the index of the event in athlete.events
                let index = event.Athletes[n].events.firstIndex(of: event.event_name) ?? 0
                
                // Show an AthleteTimeView of the athlete with the parameters
                AthleteTimeView(position: "\(event.Athletes[n].positions[index]).", name: event.Athletes[n].name, team: event.Athletes[n].team, time: event.Athletes[n].times[index], performance: event.Athletes[n].performances[index], score: event.Athletes[n].scores[index])
            }
            
            // Spacer to push the add times button to the bottom
            Spacer()
            
            // Button to add times for the event
            Text("Add Times")
            
            // When the button is pressed it toggles presentAddTimesScreen
            Button(action: {
                presentAddTimesScreen.toggle()
            }, label: {
                
                // Shows a +
                Image(systemName: "plus")
                    .font(.system(size: 25))
            })
            // Shows the AddTimesView if the presentAddTimesScreen is true
            .sheet(isPresented: $presentAddTimesScreen) {
                AddTimesView(event: event, tournamentName: tournamentName)
            }
        }
        
        // When the event appears
        .onAppear(perform: {
            
            // Set the chosenAgeGroup and chosenGender to default values
            chosenAgeGroup = event.age_groups[0]
            if event.genders[0] {
                chosenGender = "Male"
            }
            
            // Go through all the athletes in the event
            for n in 0..<event.Athletes.count {
                
                // Add the event name to the events list for the athlete
                event.Athletes[n].events.append(event.event_name)
                
                // Find the index of the event in athlete.events
                let ind = event.Athletes[n].events.firstIndex(of: event.event_name) ?? 0
                
                // Add the times from the event for the athlete and a random position
                times.append(event.Athletes[n].times[ind])
                positions.append(n)
            }
            
            // Bubble Sort to sort the positions
            
            // If there is more than 1 time
            if times.count > 1 {
                
                // go through all the times
                for i in 0..<times.count {
                    
                    // go through all the times before that time
                    for j in 0..<times.count - i - 1 {
                        
                        // If the time before is bigger than the time after
                        if times[j] > times[j + 1] {
                            
                            // Swap the times and positions (which acts as an ID at this stage)
                            times.swapAt(j + 1, j)
                            positions.swapAt(j + 1, j)
                        }
                    }
                }
            }
            
            // Go through the positions
            for n in 0..<positions.count {
                
                // Find where the athlete is on the list by using the positions which we had set earlier as a kind of ID
                let athleteInd = positions[n]
                
                // Find the index of the event in athlete.events
                let ind = event.Athletes[athleteInd].events.firstIndex(of: event.event_name) ?? 0
                
                // Set the athletes position to n + 1
                event.Athletes[athleteInd].positions[ind] = "\(n + 1)"
                
                // Set score
                event.Athletes[athleteInd].scores[ind] = positions.count - n + 1
            }
        })
    }
}
