//
//  ViewOrganizer.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 18/09/2021.
//


import SwiftUI

// A class which we can call upon which identifies which view we are on and allows our tab bar to work
class ViewOrganizer: ObservableObject {
    
    @Published var currentView: WhichView = .home
    
}

// These are the different tabs that could be opened
enum WhichView {
    case home
    case analysis
    case info
    case signOut
}
