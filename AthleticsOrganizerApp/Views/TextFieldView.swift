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
    
    @State var presentAlert = false
    
    // The body of the TextFieldView
    var body: some View {
        
        
        // HStack to structure the TextField
        HStack {
            
            // Textfield which takes the time as an input
            TextField("\(event.Athletes[n].name) time: ", text: $time)
                .padding()
                .keyboardType(.decimalPad)
            
            
            // Button which submits the time
            Button(action: {
                if time != "" {
                    // Converts the time from a string to a double
                    let doubleTime: Double = Double(time) ?? 0.0
                    
                    if doubleTime == 0.0 {
                        presentAlert.toggle()
                    }
                    
                    // Adds the time to the athlete
                    event.Athletes[n].times[index] = doubleTime
                    
                    // Calculate performance
                    let NR : Double = event.NR
                    let NS : Double = event.NS
                    let ES : Double = event.ES
                    let CS : Double = event.CS
                    
                    // Means of the two variables
                    let xMean : Double = (NR + NS + ES + CS) / 4
                    let yMean : Double = 2.5
                    
                    // Calculating numerator and denominator
                    let numerator : Double = (NR * 1 + NS * 2 + ES * 3 + CS * 4) - 4 * xMean * yMean
                    let denominator : Double = (pow(NR, 2) + pow(NS, 2) + pow(ES, 2) + pow(CS, 2)) - 4 * pow(xMean, 2)
                    
                    // Calculating gradient and y-intercept of the line
                    let gradient : Double = numerator / denominator
                    let y_intercept : Double = yMean - gradient * xMean
                    
                    // Calculating the performance
                    let performance : Double = y_intercept + gradient * doubleTime
                    
                    // Storing the performance
                    event.Athletes[n].performances[index] = performance
                    
                    // Saves the athlete to firestore
                    viewModel.saveAthlete(tournamentName: tournamentName, event: event, athlete: event.Athletes[n])
                    
                    if doubleTime != 0.0 {
                        // Tells the user that the time has been submitted
                        time = "Time Submitted"
                    } else {
                        time = ""
                    }
                }
            }, label: {
                
                // UI of the button
                Text("Submit")
            })
            .alert(isPresented: $presentAlert) {
                Alert(title: Text("Please input valid numbers"), message: Text("You inputted an invalid type"), dismissButton: .default(Text("OK")))
            }
        }
    }
}
