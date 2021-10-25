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
    
    @State private var presentAddNewAthletesScreen = false
    @State private var chosenGender: String = "Male"
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
                        Button(action: {
                            self.genderExpand.toggle()
                            chosenGender = "Male"
                        }, label: {
                            Text("Male")
                                .padding()
                                .foregroundColor(.black)
                        })
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

            Spacer()
            Text("Add Times")
            Button( action: { presentAddNewAthletesScreen.toggle() }, label: {
                Image(systemName: "plus")
                    .font(.system(size: 25))
            })
        }
        .sheet(isPresented: $presentAddNewAthletesScreen) {
            AddTimesView()
        }
        .onAppear(perform: {
            chosenAgeGroup = event.age_groups[0]
        })
    }
}

