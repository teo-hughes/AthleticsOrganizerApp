//
//  CreateTournamentView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 14/10/2021.
//


// Importing SwiftUI
import SwiftUI


// This View will allow users to create a tournament
struct CreateTournamentView: View {
    
    
    // Access the tournament and eventViewModels to send data to firestore
    @StateObject var viewModel = TournamentViewModel()
    @StateObject var eventViewModel = EventViewModel()
    
    // Variable which is the mode of the sheet (allows us to dismiss it)
    @Environment(\.presentationMode) var presentationMode
    
    // Variables which will hold some of the data of the tournament
    @State private var ChosenAgeGroups: [String] = []
    @State private var ChosenAgeGroup: String = ""
    @State private var ChosenGenders: [String] = []
    @State private var expand = false
    @State private var male = false
    @State private var female = false
    
    // Variable which will show an alert if there is an error
    @State private var presentErrorAlert = false
    
    
    // The body of CreateTournamentView
    var body: some View {
        
        
        // NavigationView allows us to have a navigation bar
        NavigationView {
            
            // Form to structure the view
            Form {
                
                // Section for the tournament details
                Section(header: Text("Tournament Details")) {
                    
                    // TextFields for Name and Location
                    TextField("Name", text: $viewModel.tournament.name)
                    TextField("Location", text: $viewModel.tournament.location)
                    
                    // DatePicker to allow the user to select a date
                    DatePicker("Date", selection: $viewModel.tournament.date, in: Date()..., displayedComponents: .date)
                    
                    // HStack to add age groups to the tournament
                    HStack {
                        
                        // Textfield for an ageGroup
                        TextField("Add Age Group", text: $ChosenAgeGroup)
                        
                        // Button to submit the ageGroup
                        Button(action: {
                            
                            // If the ageGroup isn't empty add it to the list
                            if ChosenAgeGroup != "" {
                                ChosenAgeGroups.append(ChosenAgeGroup)
                                ChosenAgeGroup = ""
                            }
                        }, label: {
                            
                            // UI of button
                            Text("Done")
                        })
                    }
                    
                    // HStack to show ageGroups
                    HStack {
                        
                        // UI of button to show ageGroups
                        Text("Age groups")
                        Spacer()
                        Image(systemName:  expand ? "chevron.up" : "chevron.down")
                        
                    // When tapped toggle expand
                    }.onTapGesture {
                        self.expand.toggle()
                    }
                    
                    // If expand is true show the ageGroups
                    if expand {
                        
                        // List to show the ageGroups
                        List {
                            
                            // UI of each ageGroup
                            ForEach(ChosenAgeGroups, id: \.self) { ageGroup in
                                Text(ageGroup)
                            }
                        }
                    }
                    
                    // HStack to pick genders
                    HStack {
                        
                        // UI of HStack
                        Text("Genders")
                        Spacer()
                        Text("Male:")
                        
                        // Checkmark for male in ZStack so I can overlap images
                        ZStack {
                            
                            // Unchecked image shown if male is false
                            Image(systemName: "circle")
                                .font(.system(size: 25))
                            
                            // If male is true
                            if male {
                                
                                // Overlap unchecked image with checked image
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 25))
                                    .foregroundColor(Color.blue)
                            }
                        }
                        // Toggle male when tapped
                        .onTapGesture {
                            self.male.toggle()
                        }
                        
                        // UI of female
                        Spacer()
                        Text("Female:")
                        
                        // Checkmark for female in ZStack so I can overlap images
                        ZStack {
                            
                            // Unchecked image shown if female is false
                            Image(systemName: "circle")
                                .font(.system(size: 25))
                            
                            // If female is true
                            if female {
                                
                                // Overlap unchecked image with cheked image
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 25))
                                    .foregroundColor(Color.red)
                            }
                        }
                        // Toggle female when tapped
                        .onTapGesture {
                            self.female.toggle()
                        }
                    }
                }
                
                
                // Section to add events to the tournament
                Section(header: Text("Events")) {
                    
                    // For all of the possible events
                    ForEach(0..<eventViewModel.possibleEvents.count) { n in
                        
                        // HStack to show the event
                        HStack {
                            
                            // UI of event (name)
                            Text(eventViewModel.possibleEvents[n].event_name)
                            Spacer()
                            
                            // Checkmark for event in ZStack so I can overlap images
                            ZStack {
                                
                                // Unchecked image shown if event.checked is false
                                Image(systemName: "circle")
                                    .font(.system(size: 25))
                                
                                // If event.checked is true
                                if eventViewModel.possibleEvents[n].checked {
                                    
                                    // Overlap unchecked image with checked image
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 25))
                                        .foregroundColor(Color.green)
                                }
                            }
                        }
                        // UI of event
                        .padding()
                        .contentShape(Rectangle())
                        // When tapped toggle event.checked
                        .onTapGesture {
                            eventViewModel.possibleEvents[n].checked.toggle()
                        }
                    }
                }
                .padding(.bottom)
            }
            // UI of navigation bar
            .navigationBarTitle("New Tournament", displayMode: .inline)
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
                    
                    // Validation to check if all key values are inputted
                    if ChosenAgeGroups != [] && (male == true || female == true) && viewModel.tournament.name != "" {
                        
                        // For each possible event
                        for n in 0..<eventViewModel.possibleEvents.count {
                            
                            // If the event has been checked
                            if eventViewModel.possibleEvents[n].checked == true {
                                
                                // Add the age groups and genders to the event
                                eventViewModel.possibleEvents[n].age_groups = ChosenAgeGroups
                                eventViewModel.possibleEvents[n].genders = [male, female]
                                
                                // Add the event to the tournament
                                viewModel.tournament.Events.append(eventViewModel.possibleEvents[n])
                            }
                        }
                        
                        // Adds the age groups and genders to the tournament
                        viewModel.tournament.ageGroups = ChosenAgeGroups
                        viewModel.tournament.genders = [male, female]
                        
                        // Dismiss the view with saving
                        handleDoneTapped()
                    
                    // If the key inputs weren't filled
                    } else {
                        
                        // Present the error alert
                        presentErrorAlert.toggle()
                    }
                }, label: {
                    
                    // UI of button
                    Text("Done")
                })
                // Alert shown when the key inputs aren't filled
                .alert(isPresented: $presentErrorAlert) {
                    
                    // Message shown to the user notifying them of their error
                    Alert(title: Text("Key information is missing"), message: Text("Check that you have inputted information for all variables, including age groups, genders and name"), dismissButton: .default(Text("OK")))
                }
            )
        }
    }
    
    // Function to dismiss when cancelled
    func handleCancelTapped() {
        dismiss()
    }
    
    // Function to save and dismiss when done is pressed
    func handleDoneTapped() {
        
        // Save the tournament to firestore
        viewModel.save()
        dismiss()
    }
    
    // Function which dismisses the view
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
