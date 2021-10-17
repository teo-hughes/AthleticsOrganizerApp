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
    
    @State var testEvents : [Event] = [Event(event: "100m", age_group: "U18", gender: "M"), Event(event: "200m", age_group: "U119", gender: "F"), Event(event: "1500m", age_group: "U15", gender: "M")]
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Tournament")) {
                    TextField("Name", text: $viewModel.tournament.name)
                    TextField("Location", text: $viewModel.tournament.location)
                    DatePicker("Date", selection: $viewModel.tournament.date, displayedComponents: .date)
                }
                Section(header: Text("Events")) {
                    TextField("AllEvents", text: $viewModel.tournament.allEvents)
                    
                    ForEach(0..<testEvents.count) { n in
                        HStack{
                            
                            Text(testEvents[n].event)
                            
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
                            print("Y")
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


