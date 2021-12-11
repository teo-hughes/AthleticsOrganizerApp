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
    
    @StateObject var userViewModel: UserViewModel
    @State var tournament: Tournament
    @Environment(\.presentationMode) var presentationMode
    
    @State private var accessCode: String = ""
    @State private var organizerExpand: Bool = false
    @State private var newOrganizerName: String = ""
    @State private var newOrganizerEmail: String = ""
    
    @State private var userSearch: String = ""
    @State private var userSearchExpand: Bool = false
    
    // The body of the InfoView
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Organizer")) {
                    
                    Text("Organizer")
                    Text("\(tournament.organizer.userName)")
                    Text("\(tournament.organizer.email)")
                    
                    Button(action: {
                        organizerExpand = true
                    }, label: {
                        Text("Change Organizer")
                    })
                    
                    if organizerExpand {
                        
                        TextField("New Organizer Username", text: $newOrganizerName)
                        TextField("New Organizer Email", text: $newOrganizerEmail)
                        
                        
                        Button(action: {
                            // Find user and if there isn't a user with this name then retry
                            
                            organizerExpand = false
                        }, label: {
                            Text("Done")
                            
                        })
                    }
                    
                }
                
                Section(header: Text("Adjudicators")) {
                    
                    // Search through users
                    // on a user, add an event
                    HStack {
                        TextField("Search for a user", text: $userSearch)
                        Button(action: {
                            
                        }, label: {
                            Text("Search")
                        })
                    }
                    
                    HStack {
                        Text("Show Adjudicators")
                        Spacer()
                        Button(action: {
                            
                            userSearchExpand.toggle()
                        }, label: {
                            Image(systemName: userSearchExpand ? "chevron.up" : "chevron.down")
                        })
                    }
                    
                    if userSearchExpand {
                        Text("Current Adjudicators")
                    }
                    
                }
                
                Section(header: Text("Access")) {
                    
                    TextField("Create access code", text: $accessCode)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    Button(action: {
                        // Confirm and create access code
                    }, label: {
                        Text("Confirm Access Code")
                    })
                }
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
