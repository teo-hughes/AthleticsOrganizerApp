//
//  AthleticsOrganizerAppApp.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 18/09/2021.
//

import SwiftUI

@main
struct AthleticsOrganizerAppApp: App {
    
    
    // Menu View is the opening View so I need its parameters
    //@StateObject var viewOrganizer = ViewOrganizer()
    
    var body: some Scene {
        WindowGroup {
            
            // Opens Menu View First
            //MenuView(viewOrganizer: viewOrganizer)
            LoginView()
        }
    }
}
