//
//  AnalysisView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 18/09/2021.
//


// Importing SwiftUI
import SwiftUI


// This View will show the athlete's personal analysis
struct AnalysisView: View {
    
    @State var score : String = ""
    @State var NSText : String = ""
    @State var NRText : String = ""
    @State var ESText : String = ""
    @State var CSText : String = ""
    @State var scoreValue : Double = 99.9
    @State var NR : Double = 99.9
    @State var NS : Double = 99.9
    @State var ES : Double = 99.9
    @State var CS : Double = 99.9
    
    @State private var performance : Double = 0.0
    
    // The body of the AnalysisView
    var body: some View {
        
        // Vstack for the text fields
        VStack {
            
            // Spacer to push the UI to the bottom
            Spacer()
            
            // Text to show it is a performance calculator
            Text("Performance Calculator")
                .foregroundColor(Color.black)
                .font(.custom("Avenir", size:25))
                .padding()
                .keyboardType(.decimalPad)
            
            // Textfield for the score
            TextField("Your Score: ", text: $score)
                .padding()
                .background(Color(.secondarySystemBackground))
                .keyboardType(.decimalPad)
            
            // Textfield for the national record
            TextField("National Record: ", text: $NRText)
                .padding()
                .background(Color(.secondarySystemBackground))
                .keyboardType(.decimalPad)
            
            // Textfield for the national standard
            TextField("National Standard: ", text: $NSText)
                .padding()
                .background(Color(.secondarySystemBackground))
                .keyboardType(.decimalPad)
            
            // Textfield for the entry standard
            TextField("Entry Standard: ", text: $ESText)
                .padding()
                .background(Color(.secondarySystemBackground))
                .keyboardType(.decimalPad)
            
            // Textfield for the county standard
            TextField("County Standard: ", text: $CSText)
                .padding()
                .background(Color(.secondarySystemBackground))
                .keyboardType(.decimalPad)
            
            Button(action: {
                
                scoreValue = (score as NSString).doubleValue
                NR = (NRText as NSString).doubleValue
                NS = (NSText as NSString).doubleValue
                ES = (ESText as NSString).doubleValue
                CS = (CSText as NSString).doubleValue
                
                let xMean : Double = (NR + NS + ES + CS) / 4
                
                let yMean : Double = 2.5
                
                let numerator : Double = (NR * 1 + NS * 2 + ES * 3 + CS * 4) - 4 * xMean * yMean
                
                let denominator : Double = (pow(NR, 2) + pow(NS, 2) + pow(ES, 2) + pow(CS, 2)) - 4 * pow(xMean, 2)
                
                let gradient : Double = numerator / denominator
                
                let y_intercept : Double = yMean - gradient * xMean
                
                performance = y_intercept + gradient * scoreValue
                
                
                
            }, label: {
                
                // UI of button
                Text("Calculate Performance")
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50)
                    .cornerRadius(8)
                    .background(Color.blue)
                    .padding()
                
            })
            Spacer()
            
            // Show the user their performance to 3 decimal places
            Text("Your Performance is " + (round(performance * 1000) / 1000).description)
                .foregroundColor(Color.black)
                .font(.custom("Avenir", size:25))
                .padding()
        }
    }
}
