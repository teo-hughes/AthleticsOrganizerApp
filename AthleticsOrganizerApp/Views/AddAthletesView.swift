//
//  AddAthletesView.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 23/10/2021.
//

import SwiftUI

struct AddAthletesView: View {
    
    @State var tournamentName: String
    @State var events: [Event]
    @State var athletes: [Athlete]
    @StateObject var viewModel = AthleteViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var ChosenTeam: String = ""
    @State private var teams: [String] = []
    @State private var teamExpand = false
    @State private var AthleteTeam: String = ""
    @State private var AthleteName: String = ""
    @State private var AthleteMale = true
    @State private var AthleteFemale = false
    @State private var AthleteGender: String = "Male"
    @State private var AthleteAgeGroup: String = ""
    @State private var ChosenAthletes: [Athlete] = []

    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Teams (Do This First!)")) {
                    
                    HStack {
                        TextField("Add Teams", text: $ChosenTeam)
                        Button(action: {
                            if ChosenTeam != "" {
                                teams.append(ChosenTeam)
                                ChosenTeam = ""
                            }
                        }, label: {
                            Text("Done")
                        })
                    }
                    HStack {
                        Text("Chosen Teams")
                        Spacer()
                        Image(systemName:  teamExpand ? "chevron.up" : "chevron.down")
                    }.onTapGesture {
                        self.teamExpand.toggle()
                    }
                    
                    if teamExpand {
                        List {
                            ForEach(teams, id: \.self) { team in
                                Text(team)
                            }
                        }
                        .refreshable {
                            
                        }
                        
                    }
                }
                Section(header: Text("Athletes")) {
                    
                    Picker("Choose a Team", selection: $AthleteTeam) {
                        ForEach(teams, id: \.self) { team in
                            Text(team)
                        }
                    }
                    Picker("Choose an AgeGroup", selection: $AthleteAgeGroup) {
                        ForEach(events[0].age_groups, id: \.self) { ageGroup in
                            Text(ageGroup)
                        }
                    }

                    HStack {
                        Text("Gender")
                        Spacer()
                        
                        Text("Male:")
                        ZStack {
                            
                            Image(systemName: "circle")
                                .font(.system(size: 25))
                            
                            if AthleteMale {
                                
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 25))
                                    .foregroundColor(Color.blue)
                            }
                        }
                        .onTapGesture {

                            self.AthleteMale.toggle()
                            self.AthleteFemale.toggle()
                            AthleteGender = "Male"
                            
                        }
                        Spacer()
                        Text("Female:")
                        ZStack {
                            
                            Image(systemName: "circle")
                                .font(.system(size: 25))
                            
                            if AthleteFemale {
                                
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 25))
                                    .foregroundColor(Color.red)
                            }
                        }
                        .onTapGesture {

                            self.AthleteFemale.toggle()
                            self.AthleteMale.toggle()
                            AthleteGender = "Female"
                            
                        }
                        
                    }
                    
                    TextField("Athlete's Name", text: $AthleteName)
                    
                    Button(action: {
                        viewModel.athletes.append(Athlete(name: AthleteName, age_group: AthleteAgeGroup, gender: AthleteGender, team: AthleteTeam))
                        ChosenAthletes.append(Athlete(name: AthleteName, age_group: AthleteAgeGroup, gender: AthleteGender, team: AthleteTeam))
                        
                        AthleteName = ""
                    }, label: {
                        Text("Add Athlete")
                    })
                    
                }
                Section(header: Text("Athletes Added")) {
                    List {
                        ForEach(0..<athletes.count) { n in
                            Text(athletes[n].name)
                        }
                    }
                }
            }
            .navigationBarTitle("Add Teams", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    handleCancelTapped()
                }, label: {
                    Text("Cancel")
                }),
                trailing: Button(action: {
                    
                    handleDoneTapped()
                    
                }, label: {
                    Text("Done")
                })
            )
        }
    }
    
    func handleCancelTapped() {
        dismiss()
    }
    
    func handleDoneTapped() {
        viewModel.save(tournamentName: tournamentName)
        dismiss()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
}
