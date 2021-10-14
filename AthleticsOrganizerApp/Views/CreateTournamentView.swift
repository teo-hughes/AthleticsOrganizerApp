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
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Tournament")) {
                    TextField("Location", text: $viewModel.tournament.location)
                }
                Section(header: Text("Events")) {
                    TextField("AllEvents", text: $viewModel.tournament.allEvents)
                }
            }
            .navigationBarTitle("New Tournament", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {}, label: {
                    Text("Cancel")
                }),
                trailing: Button(action: {}, label: {
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
