//
//  SearchAthletesView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 26/10/2021.
//


// Importing SwiftUI
import SwiftUI


// This view will allow the user to pick athletes for an event
struct SearchAthletesView: View {
    
    
    // Fetch data from the eventView
    @State var event: Event
    @State var tournamentAthletes: [Athlete]
    @State var chosenAgeGroup: String
    @State var chosenGender: String
    @State var tournamentName: String
    
    // Connect to the eventViewModel to write data to firestore
    @StateObject var viewModel = EventViewModel()
    
    // Variable which is the mode of the sheet (allows us to dismiss it)
    @Environment(\.presentationMode) var presentationMode
    
    // Variables which will hold data about the athletes
    @State var AthleteNames: [String] = []
    @State var AthletesChecked: [Bool] = []
    @State var AthleteIndexes: [Int] = []
    
    
    // The body of the SearchAthletesView
    var body: some View {
        
        
        // NavigationView alows us to have a navigation bar
        NavigationView {
            
            // List which will show all the athletes
            List {
                
                // For all the athletes available
                ForEach(0..<AthleteNames.count, id: \.self) { n in
                    
                    // HStack to structure the UI of the athlete
                    HStack {
                        
                        // UI of the athlete
                        Text(AthleteNames[n])
                        Spacer()
                        
                        // Checkmark for the athlete in ZStack so I can overlap images
                        ZStack {
                            
                            // Unchecked image shown if athlete not checked
                            Image(systemName: "circle")
                                .font(.system(size: 25))
                            
                            // If the athlete is checked
                            if AthletesChecked[n] {
                                
                                // Overlap unchecked image with checked image
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 25))
                                    .foregroundColor(Color.green)
                            }
                        }
                    }
                    .padding()
                    .contentShape(Rectangle())
                    // Toggle AthletesChecked[n] when tapped
                    .onTapGesture {
                        AthletesChecked[n].toggle()
                    }
                }
            }
            // UI of navigation bar
            .navigationTitle("Add Athletes")
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
                    
                    // For all the athletes
                    for n in 0..<AthletesChecked.count {
                        
                        // If the athlete was checked
                        if AthletesChecked[n] {
                            
                            // Add the event, position and time to the athlete
                            tournamentAthletes[AthleteIndexes[n]].events.append(event.event_name)
                            tournamentAthletes[AthleteIndexes[n]].positions.append("N/A")
                            tournamentAthletes[AthleteIndexes[n]].times.append(0.0)
                            tournamentAthletes[AthleteIndexes[n]].performances.append(0.0)
                            tournamentAthletes[AthleteIndexes[n]].scores.append(1)
                            
                            // Add the athlete to the event
                            event.Athletes.append(tournamentAthletes[AthleteIndexes[n]])
                        }
                    }
                    
                    // Dismiss the view with saving
                    handleDoneTapped()
                }, label: {
                    
                    // UI of button
                    Text("Done")
                })
            )
        }
        // When the view appears
        .onAppear(perform: {
            
            // For all the athletes in the tournament
            for n in 0..<tournamentAthletes.count {
                
                // If the age group and gender correspond
                if tournamentAthletes[n].age_group == chosenAgeGroup && tournamentAthletes[n].gender == chosenGender {
                    
                    // Add the data to the lists AthleteNames, AthletesChecked and AthleteIndexes
                    AthleteNames.append(tournamentAthletes[n].name)
                    AthletesChecked.append(false)
                    AthleteIndexes.append(n)
                }
            }
        })
    }
    
    // Function to dismiss when cancelled
    func handleCancelTapped() {
        dismiss()
    }
    
    // Function to save and dismiss when done is pressed
    func handleDoneTapped() {
        
        // Save the event to firestore
        viewModel.saveEvent(tournamentName: tournamentName, event: event)
        dismiss()
    }
    
    // Function which dismisses the view
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
