//
//  EventView.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 18/10/2021.
//

import SwiftUI

// This view will provide info surrounding the app's functions
struct EventView: View {
    
    @State var event: Event
    @State var tournamentAthletes: [Athlete]
    @State var tournamentName: String
    
    @State private var presentAddNewAthletesScreen = false
    @State private var presentAddTimesScreen = false
    @State private var chosenGender: String = "Female"
    @State private var chosenAgeGroup: String = ""
    @State private var genderExpand: Bool = false
    @State private var ageGroupExpand: Bool = false
    
    // The body of the InfoView
    var body: some View {
        

        VStack {
            
            HStack {
                VStack(spacing: 10) {
                    HStack {
                        Text(chosenGender)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Image(systemName: genderExpand ? "chevron.up": "chevron.down")
                            .resizable().frame(width: 13, height: 6)
                            .foregroundColor(.black)
                        
                    }.onTapGesture {
                        self.genderExpand.toggle()
                    }
                    if genderExpand {
                        
                        if event.genders[0] {
                            Button(action: {
                                self.genderExpand.toggle()
                                chosenGender = "Male"
                            }, label: {
                                Text("Male")
                                    .padding()
                                    .foregroundColor(.black)
                            })
                        }
                        if event.genders[1] {
                            Button(action: {
                                self.genderExpand.toggle()
                                chosenGender = "Female"
                            }, label: {
                                Text("Female")
                                    .padding()
                                    .foregroundColor(.black)
                            })
                        }
                    }
                }
                .padding()
                
                
                Spacer()
                
                
                VStack(spacing: 10) {
                    HStack {
                        Text(chosenAgeGroup)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Image(systemName: ageGroupExpand ? "chevron.up": "chevron.down")
                            .resizable().frame(width: 13, height: 6)
                            .foregroundColor(.black)
                        
                    }.onTapGesture {
                        self.ageGroupExpand.toggle()
                    }
                    if ageGroupExpand {
                        ForEach(event.age_groups, id: \.self) { ageGroup in
                            Button(action: {
                                self.ageGroupExpand.toggle()
                                chosenAgeGroup = ageGroup
                            }, label: {
                                Text(ageGroup)
                                    .padding()
                                    .foregroundColor(.black)
                            })
                        }
                    }
                }

            }
            .padding()
            
            Text("Add Athletes For Event")
            Button(action: {
                presentAddNewAthletesScreen.toggle()
            }, label: {
                Image(systemName: "plus")
                    .font(.system(size: 25))
            })
            .sheet(isPresented: $presentAddNewAthletesScreen) {
                SearchAthletesView(event: event, tournamentAthletes: tournamentAthletes, chosenAgeGroup: chosenAgeGroup, chosenGender: chosenGender, tournamentName: tournamentName)
            }
            
            
            
            Spacer()
            Text(event.event_name)
            
            HStack {
                Text("Position")
                Text("Name")
                Text("Team")
                Text("Time")
            }
            
            ForEach(0..<event.Athletes.count, id: \.self) { n in
                
                let index = event.Athletes[n].events.firstIndex(of: event.event_name) ?? 0
                
                
                athleteTimeView(position: "\(event.Athletes[n].positions[index]).", name: event.Athletes[n].name, team: event.Athletes[n].team, time: event.Athletes[n].times[index])
                
                
            }
            Spacer()
            
            Text("Add Times")
            Button( action: { presentAddTimesScreen.toggle() }, label: {
                Image(systemName: "plus")
                    .font(.system(size: 25))
            })
            .sheet(isPresented: $presentAddTimesScreen) {
                AddTimesView(event: event, tournamentName: tournamentName)
            }
            
        }
        
        
        .onAppear(perform: {
            chosenAgeGroup = event.age_groups[0]
            if event.genders[0] {
                chosenGender = "Male"
            }
            for n in 0..<event.Athletes.count {
                event.Athletes[n].events.append(event.event_name)
            }
        })
    }
}

struct athleteTimeView: View {
    
    @State var position: String
    @State var name: String
    @State var team: String
    @State var time: Double
    
    
    
    var body: some View {
        HStack {
            Text(position)
            Text(name)
            Text(team)
            Text(time.description)
        }
    }
    
}
