//
//  CreateTournamentView.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 14/10/2021.
//

import SwiftUI



struct CreateTournamentView: View {
    
    @StateObject var viewModel = TournamentViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @State private var ChosenAgeGroups: [String] = []
    @State private var ChosenAgeGroup: String = ""
    @State private var ChosenGenders: [String] = []
    @State private var expand = false
    @State private var male = false
    @State private var female = false
    
    @State var testEvents : [Event] = [Event(event_name: "100m", age_groups: [], genders: []), Event(event_name: "200m", age_groups: [], genders: []), Event(event_name: "1500m", age_groups: [], genders: [])]
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Tournament Details")) {
                    TextField("Name", text: $viewModel.tournament.name)
                    TextField("Location", text: $viewModel.tournament.location)
                    DatePicker("Date", selection: $viewModel.tournament.date, displayedComponents: .date)
                    HStack {
                        TextField("Add Age Group", text: $ChosenAgeGroup)
                        Button(action: {
                            if ChosenAgeGroup != "" {
                                ChosenAgeGroups.append(ChosenAgeGroup)
                                ChosenAgeGroup = ""
                            }
                        }, label: {
                            Text("Done")
                        })
                    }
                    HStack {
                        Text("Age groups")
                        Spacer()
                        Image(systemName:  expand ? "chevron.up" : "chevron.down")
                    }.onTapGesture {
                        self.expand.toggle()
                    }
                    
                    if expand {
                        List {
                        ForEach(ChosenAgeGroups, id: \.self) { ageGroup in
                                Text(ageGroup)
                            }
                        }
                        
                    }
                    
                    HStack {
                        Text("Genders")
                        Spacer()
                        
                        Text("Male:")
                        ZStack {
                            
                            Image(systemName: "circle")
                                .font(.system(size: 25))
                            
                            if male {
                                
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 25))
                                    .foregroundColor(Color.blue)
                            }
                        }
                        .onTapGesture {
                            self.male.toggle()
                        }
                        Spacer()
                        Text("Female:")
                        ZStack {
                            
                            Image(systemName: "circle")
                                .font(.system(size: 25))
                            
                            if female {
                                
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 25))
                                    .foregroundColor(Color.red)
                            }
                        }
                        .onTapGesture {
                            self.female.toggle()
                        }
                        
                    }
                    
                    
                }
                Section(header: Text("Events")) {
                    
                    ForEach(0..<testEvents.count) { n in
                        HStack{
                            
                            Text(testEvents[n].event_name)
                            
                            Spacer()
                            
                            ZStack {
                                
                                Image(systemName: "circle")
                                    .font(.system(size: 25))
                                
                                if testEvents[n].checked {
                                    
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 25))
                                        .foregroundColor(Color.green)
                                }
                                
                            }
                        }
                        .padding()
                        .contentShape(Rectangle())
                        .onTapGesture {
                            testEvents[n].checked.toggle()
                        }
                    }
                }
                .padding(.bottom)
            }
            .navigationBarTitle("New Tournament", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    handleCancelTapped()
                }, label: {
                    Text("Cancel")
                }),
                trailing: Button(action: {
                    
                    
                    
                    for n in 0...2 {
                        
                        
                        if testEvents[n].checked == true {
                            
                            testEvents[n].age_groups = ChosenAgeGroups
                            testEvents[n].genders = [male, female]
                            viewModel.tournament.Events.append(testEvents[n])
                        }
                    }
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


