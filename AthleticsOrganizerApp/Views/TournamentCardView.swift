//
//  TournamentCardView.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 09/10/2021.
//

import SwiftUI

// This View will show the athlete's personal analysis
struct TournamentCardView: View {
    
    @State private var clicked = false
    var tournamentViewModel: TournamentViewModel
    
    // The body of the AnalysisView
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(clicked ? Color.blue: Color.red)
            .frame(height: 150)
            .overlay(
                ZStack {
                    Text(tournamentViewModel.text)
                        .foregroundColor(Color.black)
                        .font(.custom("Avenir", size:25))
                }.padding()
            )
            .onTapGesture {
                withAnimation {
                    clicked.toggle()
                }
            }
    }
}
