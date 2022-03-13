//
//  ViewOrganizer.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 18/09/2021.
//


// Imported to access attributes such as DocumentID
import SwiftUI


// A class which we can call upon which identifies which view we are on and allows our tab bar to work
class ViewOrganizer: ObservableObject {
    
    // Default value is home
    @Published var currentView: WhichView = .home
}


// These are the different tabs that could be selected
enum WhichView {
    case home
    case analysis
    case info
    case signOut
}
