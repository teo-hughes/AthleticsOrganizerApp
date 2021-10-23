//
//  AddAthletesView.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 23/10/2021.
//

import SwiftUI

struct AddAthletesView: View {
    
    
    @State var events: [Event]
    @StateObject var viewModel = AthleteViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var ChosenTeam: String = ""
    @State private var teams: [String] = []
    @State private var teamExpand = false
    @State private var AthleteTeam: String = ""
    @State private var AthleteName: String = ""
    @State private var AthleteGender: String = ""
    @State private var AthleteAgeGroup: String = ""
    
    
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
                }
                Section(header: Text("Athletes Added")) {
                    
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
        viewModel.save()
        dismiss()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
}
