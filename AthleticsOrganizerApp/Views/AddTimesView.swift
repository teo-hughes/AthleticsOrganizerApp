//
//  AddTimesView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 25/10/2021.
//


// Importing SwiftUI
import SwiftUI


// This view will allow the user to add the times of an event
struct AddTimesView: View {
    
    
    // Fetch the data from EventView
    @State var event: Event
    @State var tournamentName: String
    
    // Access the event view model
    @StateObject var viewModel = EventViewModel()
    
    // Variable which is the mode of the sheet (allows us to dismiss it)
    @Environment(\.presentationMode) var presentationMode
    
    
    // The body of the AddTimesView
    var body: some View {
        
        
        // NavigationView allows us to have a navigation bar
        NavigationView {
            
            // Form to structure the view
            Form {
                
                // Section to add times
                Section(header: Text("Add Times")) {
                    
                    // List to go through all the athletes in the events
                    List {
                        
                        // For each of the athletes
                        ForEach(0..<event.Athletes.count, id: \.self) { n in
                            
                            // Find the index of the event in athlete.events
                            let index = event.Athletes[n].events.firstIndex(of: event.event_name) ?? 0
                            
                            // Show the TextFieldView with the parameters
                            TextFieldView(n: n, index: index, event: event, tournamentName: tournamentName, viewModel: viewModel)
                        }
                    }
                }
            }
            // UI of the navigation bar
            .navigationBarItems(
                
                // Leading button to cancel
                leading: Button(action: {
                    
                    // Dismiss the view without saving
                    handleCancelTapped()
                }, label: {
                    
                    // UI of button
                    Text("Cancel")
                }),
                
                // Trailing button to save
                trailing: Button(action: {
                    
                    // Dismiss the view without saving (not needed as TextFieldView saves it)
                    handleDoneTapped()
                }, label: {
                    
                    // UI of button
                    Text("Done")
                })
            )
        }
    }
    
    // Function to dismiss when cancelled
    func handleCancelTapped() {
        dismiss()
    }
    
    // Function to dismiss when done is pressed
    func handleDoneTapped() {
        dismiss()
    }
    
    // Function which dismisses the view
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
