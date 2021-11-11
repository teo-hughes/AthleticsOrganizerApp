//
//  MenuView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 18/09/2021.
//

import SwiftUI

// This View is to host the tab bar and all the views will be shown in here
struct MenuView: View {
    
    // Accessing the data from the ViewOrganizer class
    @StateObject var viewOrganizer = ViewOrganizer()
    
    
    // The body of the MenuView
    var body: some View {
        
        // A Geometry Reader so we can customise the tab bar
        GeometryReader { geometry in
            
            // A VStack allows the tab bar to either be in the top or the bottom
            VStack{
                
                // Shows a view depending on which tab is selected
                switch viewOrganizer.currentView {
                    
                    // Shows the MainView if the home icon is selected
                case .home:
                    MainView()
                    
                    // Shows the AnalysisView if the analysis icon is selcted
                case .analysis:
                    AnalysisView()
                    
                    // Shows the InfoView if the info icon is selected
                case .info:
                    InfoView()
                    
                    // Shows the LoginView if the sign out icon is selected
                case .signOut:
                    LoginView()
                }
                
                
                
                // Pushes the tab bar to the bottom
                Spacer()
                
                // A HStack allows the tab icons to be displayed horizontally along the bar
                HStack {
                    
                    // Icon for the home page (MainView)
                    TabBarIcon(viewOrganizer: viewOrganizer, assignedView: .home, width: geometry.size.width/4, height: geometry.size.height/24, systemIconName: "house", tabName: "Home")
                    
                    // Icon for the info page (InfoView)
                    TabBarIcon(viewOrganizer: viewOrganizer, assignedView: .info, width: geometry.size.width/4, height: geometry.size.height/24, systemIconName: "info.circle", tabName: "Info")
                    
                    // Icon for the analysis page (AnalysisView)
                    TabBarIcon(viewOrganizer: viewOrganizer, assignedView: .analysis, width: geometry.size.width/4, height: geometry.size.height/24, systemIconName: "person.crop.circle", tabName: "Your Analysis")
                    
                    // Icon to sign out
                    TabBarIcon(viewOrganizer: viewOrganizer, assignedView: .signOut, width: geometry.size.width/4, height: geometry.size.height/24, systemIconName: "delete.left.fill", tabName: "Sign Out")
                }
                // Sets the UI of the tab bar
                .frame(width: geometry.size.width, height: geometry.size.height/10)
                .background(Color.gray).shadow(radius: 2)
            }
            // Makes it such that the tab bar goes right to the bottom
            .edgesIgnoringSafeArea(.all)
        }
    }
}







