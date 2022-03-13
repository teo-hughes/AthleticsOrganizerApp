//
//  TournamentCardView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 09/10/2021.
//


// Importing SwiftUI
import SwiftUI


// This View will show the tournament card
struct TournamentCardView: View {
    
    
    // Fetching the tournament as a parameter
    @State var tournament: Tournament
    
    
    // The body of the TournamentCardView
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
                        
                        // Name of the tournament
                        Text(tournament.name)
                            .foregroundColor(Color.black)
                            .font(.custom("Avenir", size:25))
                        
                        // Location and date of the tournament
                        HStack {
                            Text("Location: \(tournament.location)")
                                .foregroundColor(Color.black)
                                .font(.custom("Avenir", size:16))
                                .padding()
                            Text("Date: \(tournament.date)")
                                .foregroundColor(Color.black)
                                .font(.custom("Avenir", size:16))
                                .padding()
                        }
                    }.padding()
                )
        }
    }
}
