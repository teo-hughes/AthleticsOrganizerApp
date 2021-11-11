//
//  TextFieldView.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 11/11/2021.
//

import SwiftUI


struct TextFieldView: View {
    
    @State var n: Int
    @State var index: Int
    @State var event: Event
    @State var tournamentName: String
    @State var viewModel: EventViewModel
    
    @State var time: String = ""
    
    var body: some View {
        HStack {
            TextField("\(event.Athletes[n].name) time: ", text: $time)
         
            Button(action: {
                
                let doubleTime: Double = Double(time) ?? 0.0
                
                event.Athletes[n].times[index] = doubleTime
                
                viewModel.saveAthlete(tournamentName: tournamentName, event: event, athlete: event.Athletes[n])
                time = "Time Submitted"
                
            }, label: {
                Text("Submit")
            })
        }
    }
}
