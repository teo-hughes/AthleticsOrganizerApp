//
//  AthleticsOrganizerAppApp.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 18/09/2021.
//

import SwiftUI
import Firebase

@main
struct AthleticsOrganizerAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    // Menu View is the opening View so I need its parameters
    //@StateObject var viewOrganizer = ViewOrganizer()
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AuthenticationViewModel()
            // Opens Menu View First
            //MenuView(viewOrganizer: viewOrganizer)
            LoginView()
                .environmentObject(viewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}
