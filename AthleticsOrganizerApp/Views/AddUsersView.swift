//
//  AddUsersView.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 03/12/2021.
//

// Importing SwiftUI
import SwiftUI


// This view will provide info surrounding the app's functions
struct AddUsersView: View {
    
    @StateObject var viewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    // The body of the InfoView
    var body: some View {
        NavigationView {
            Form {
                Text("Add Users View")
                    .padding()
            }
            // UI of navigation bar
            .navigationBarTitle("Add Users", displayMode: .inline)
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
                    
                    // Dismiss the view with saving
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
    
    // Function to save and dismiss when done is pressed
    func handleDoneTapped() {
        
        // Save the athlete to firestore
       
        dismiss()
    }
    
    // Function which dismisses the view
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
