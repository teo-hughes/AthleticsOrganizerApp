//
//  ViewOrganizer.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 18/09/2021.
//

import SwiftUI

class ViewOrganizer: ObservableObject {
    
    @Published var currentView: WhichView = .home
    
}


enum WhichView {
    case home
    case tournaments
    case analysis
    case info
    case signOut
}
