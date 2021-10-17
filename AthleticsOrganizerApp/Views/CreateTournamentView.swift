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
    
    @State var testEvents = [Event(event: "100m", age_group: "U18", gender: "M"), Event(event: "200m", age_group: "U119", gender: "F"), Event(event: "1500m", age_group: "U15", gender: "M")]
    
    
    
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
                    EventPickerView(event: testEvents[0])
                    EventPickerView(event: testEvents[1])
                    EventPickerView(event: testEvents[2])
                }
                .padding(.bottom)
            }
            .navigationBarTitle("New Tournament", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: { handleCancelTapped() }, label: {
                    Text("Cancel")
                }),
                trailing: Button(action: { handleDoneTapped() }, label: {
                    Text("Done")
                })
            )
        }
    }
    
    func handleCancelTapped() {
        dismiss()
    }
    
    func handleDoneTapped() {
        if testEvents[0].checked {
            viewModel.tournament.Events.append(testEvents[0])
        }
        if testEvents[1].checked {
            viewModel.tournament.Events.append(testEvents[1])
        }
        if testEvents[2].checked {
            viewModel.tournament.Events.append(testEvents[2])
        }
        viewModel.save()
        dismiss()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}


struct EventPickerView: View {
    
    @State var event: Event
    
    var body: some View {
        
        HStack{
            
            Text(event.event)
            
            Spacer()
            
            ZStack {
                Circle()
                    .stroke(event.checked ? Color.green : Color.gray)
                    .frame(width: 25, height: 25)
                
                if event.checked {
                    
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(Color.green)
                }
                
            }
        }
        .padding()
        .contentShape(Rectangle())
        .onTapGesture {
            event.checked.toggle()
        }
    }
}
