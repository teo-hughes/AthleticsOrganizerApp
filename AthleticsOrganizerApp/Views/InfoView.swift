//
//  InfoView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 18/09/2021.
//


// Importing SwiftUI
import SwiftUI

// Importing AVKit for the video player
import AVKit


// This view will provide info surrounding the app's functions
struct InfoView: View {
    
    
    // The body of the InfoView
    var body: some View {
        
        // The video player which will show the video
        VideoPlayer(player: AVPlayer(url: URL(string: "https://www.youtube.com/watch?v=W9nZ6u15yis")!))
        
        // A VStack which will show some corresponding text
        VStack {
            Text("Info View")
                .font(.custom("Avenir", size: 50))
                .foregroundColor(.black)
        }
    }
}
