//
//  TabBarIcon.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 11/11/2021.
//

import SwiftUI

// This is the struct of each individual icon
struct TabBarIcon: View {
    
    // Accesses the AuthenticationViewModel
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    // Accesses the ViewOrganizer
    @StateObject var viewOrganizer: ViewOrganizer
    
    // The variable which identifies which view it is on
    let assignedView: WhichView
    
    // The UI of the icon
    let width, height: CGFloat
    let systemIconName, tabName: String
    
    // The body of the icon
    var body: some View {
        
        // A VStack allows us to put an image on top of text
        VStack{
            
            // The icon image
            Image(systemName: systemIconName)
            // The UI of the image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
            
            // The text that goes below the image
            Text(tabName)
                .font(.footnote)
        }
        // The UI of the VStack
        .padding(.horizontal, -10)
        .foregroundColor(viewOrganizer.currentView == assignedView ? .blue : .black)
        // When the icon is tapped
        .onTapGesture {
            
            // Set the current view to the view of the icon
            viewOrganizer.currentView = assignedView
            
            // If the icon tapped was the sign out icon, sign out using the viewModel
            if tabName == "Sign Out" {
                viewModel.signOut()
            }
        }
    }
}
