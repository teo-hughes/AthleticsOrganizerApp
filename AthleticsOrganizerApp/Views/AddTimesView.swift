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
                            textFieldView(n: n, index: index, event: event, tournamentName: tournamentName, viewModel: viewModel)
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
    
    @State var n: Int
    @State var index: Int
    @State var event: Event
    @State var tournamentName: String
    @State var viewModel: EventViewModel
    
    @State var time: String = ""
    
    var body: some View {
        HStack {
            TextField("\(event.Athletes[n].name) time: ", text: $time)
         
            Button(action: {
                
                let doubleTime: Double = Double(time) ?? 0.0
                
                event.Athletes[n].times[index] = doubleTime
                
                viewModel.saveAthlete(tournamentName: tournamentName, event: event, athlete: event.Athletes[n])
                time = "Time Submitted"
                
            }, label: {
                Text("Submit")
            })
        }
    }
}
