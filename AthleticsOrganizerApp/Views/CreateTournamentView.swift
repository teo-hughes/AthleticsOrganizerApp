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
    
    @State private var testEvents = [Event(event: "100m", age_group: "U18", gender: "M"), Event(event: "200m", age_group: "U119", gender: "F"), Event(event: "1500m", age_group: "U15", gender: "M")]
    
    @State private var testEvent: Event = Event(event: "100m", age_group: "U18", gender: "M")
    
    
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
                    ForEach(testEvents) { event in
                        EventPickerView(event: event)
                    }
                }
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
        viewModel.tournament.Events.append(testEvent)
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
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(width: 25, height: 25)
            }
        }
    }
}
