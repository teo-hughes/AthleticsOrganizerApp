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
                
                // Calculate performance
                let NR = event.NR
                let NS = event.NS
                let ES = event.ES
                let CS = event.CS
                
                let xMean = (NR + NS + ES + CS) / 4
                
                let yMean = 2.5
                
                let numerator = (NR * 1 + NS * 2 + ES * 3 + CS * 4) - 4 * xMean * yMean
                
                let denominator = ((NR ^ 2) + (NS ^ 2) + (ES ^ 2) + (CS ^ 2)) - 4 * (xMean ^ 2)
                
                let gradient = numerator / denominator
                
                let y_intercept = yMean - gradient * xMean
                
                let performance = y_intercept + gradient * doubleTime
                
                event.Athletes[n].performances[index] = performance
                
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
