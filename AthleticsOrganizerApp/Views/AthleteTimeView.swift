//
//  AthleteTimeView.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 11/11/2021.
//

import SwiftUI

struct AthleteTimeView: View {
    
    @State var position: String
    @State var name: String
    @State var team: String
    @State var time: Double
    
    
    
    var body: some View {
        HStack {
            Text(position)
            Text(name)
            Text(team)
            Text(time.description)
        }
    }
    
}
