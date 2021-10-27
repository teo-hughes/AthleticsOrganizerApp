//
//  AddTimesView.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 25/10/2021.
//

import SwiftUI

// This view will provide info surrounding the app's functions
struct AddTimesView: View {
    
    @State var event: Event

    
    
    
    // The body of the InfoView
    var body: some View {

        ForEach(0..<event.Athletes.count, id: \.self) { n in
            Text(event.Athletes[n].name)
        }
    }
    
}
