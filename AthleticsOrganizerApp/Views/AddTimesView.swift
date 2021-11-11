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
                            TextFieldView(n: n, index: index, event: event, tournamentName: tournamentName, viewModel: viewModel)
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



