//
//  EventView.swift
//  AthleticsOrganizerApp
//
//  Created by Neil Hughes on 18/10/2021.
//

import SwiftUI

// This view will provide info surrounding the app's functions
struct EventView: View {
    
    @State var event: Event
    // The body of the InfoView
    var body: some View {
        Text(event.event_name)
            .padding()
    }
}

