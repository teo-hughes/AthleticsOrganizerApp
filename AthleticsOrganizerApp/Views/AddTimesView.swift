//
//  AddTimesView.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 25/10/2021.
//

import SwiftUI

// This view will provide info surrounding the app's functions
struct AddTimesView: View {
    
    @State var event: Event
    @State var tournamentName: String
    @StateObject var viewModel = EventViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    // The body of the InfoView
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Add Times")) {
                    List {
                        ForEach(0..<event.Athletes.count, id: \.self) { n in
                            
                            let index = event.Athletes[n].events.firstIndex(of: event.event_name) ?? 0
                            Text(event.Athletes[n].name)
                            textFieldView(athlete: event.Athletes[n], n: n, index: index, viewModel: viewModel, tournamentName: tournamentName, event: event)
                        }
                    }
                }
            }

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
        dismiss()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
}


struct textFieldView: View {
    
    @State var athlete: Athlete
    @State var n: Int
    @State var index: Int
    @StateObject var viewModel: EventViewModel
    @State var tournamentName: String
    @State var event: Event
    
    @State var time: String = "Time"
    
    var body: some View {
        HStack {
            TextField("\(athlete.name) time: ", text: $time)
         
            Button(action: {
                
                let doubleTime: Double = Double(time) ?? 0.0
                
                event.Athletes[n].times[index] = doubleTime
                
                viewModel.saveEvent(tournamentName: tournamentName, event: event)
                time = "Time Submitted"
                
            }, label: {
                Text("Submit")
            })
        }
    }
}
