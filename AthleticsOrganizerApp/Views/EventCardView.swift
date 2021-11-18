//
//  EventCardView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 18/10/2021.
//


// Importing SwiftUI
import SwiftUI


// This View will show the event card
struct EventCardView: View {
    
    
    // Fetching the event as a parameter
    @State var event: Event
    
    
    // The body of the EventCardView
    var body: some View {
        
        
        // VStack to structure the Card
        VStack {
            
            // Rounded Rectangle is the shape of the card
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red)
                .frame(height: 150)
                .overlay(
                    
                    // Information inside the VStack
                    VStack {
                        
                        // Name of the event
                        Text(event.event_name)
                            .foregroundColor(Color.black)
                            .font(.custom("Avenir", size:25))
                    }.padding()
                )
        }
    }
}
