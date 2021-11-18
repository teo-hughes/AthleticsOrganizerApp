//
//  TextFieldView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 11/11/2021.
//


// Importing SwiftUI
import SwiftUI


// This view is my take on a TextField
struct TextFieldView: View {
    
    // Fetch the parameters from AddTimesView
    @State var n: Int
    @State var index: Int
    @State var event: Event
    @State var tournamentName: String
    @State var viewModel: EventViewModel
    
    // Variable which will hold the time
    @State var time: String = ""
    
    
    // The body of the TextFieldView
    var body: some View {
        
        
        // HStack to structure the TextField
        HStack {
            
            // Textfield which takes the time as an input
            TextField("\(event.Athletes[n].name) time: ", text: $time)
            
            
            // Button which submits the time
            Button(action: {
                
                // Converts the time from a string to a double
                let doubleTime: Double = Double(time) ?? 0.0
                
                // Adds the time to the athlete
                event.Athletes[n].times[index] = doubleTime
                
                // Saves the athlete to firestore
                viewModel.saveAthlete(tournamentName: tournamentName, event: event, athlete: event.Athletes[n])
                
                // Tells the user that the time has been submitted
                time = "Time Submitted"
            }, label: {
                
                // UI of the button
                Text("Submit")
            })
        }
    }
}
