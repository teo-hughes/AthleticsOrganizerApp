//
//  AthleteTimeView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 11/11/2021.
//


// Importing SwiftUI
import SwiftUI


// This View shows the athlete and their time, position, team in the table in EventView
struct AthleteTimeView: View {
    
    
    // Fetch the parameters from EventView
    @State var position: String
    @State var name: String
    @State var team: String
    @State var time: Double
    @State var performance: Double
    @State var score: Int
    
    
    // The body of AthleteTimeView
    var body: some View {
        
        // HStack to represent a row in the table
        HStack {
            
            // The information about the athlete
            Text(position)
            Text(name)
            Text(team)
            Text(time.description)
            Text((round(performance * 1000) / 1000).description)
            Text(score.description)
        }
    }
}
