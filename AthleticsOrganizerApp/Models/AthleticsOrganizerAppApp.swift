//
//  AthleticsOrganizerAppApp.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 18/09/2021.
//


// Imported Firebase and SwiftUI to access them when launching the app
import SwiftUI
import Firebase


// This struct is for the app as a whole and identifies what view should be opened first
@main
struct AthleticsOrganizerAppApp: App {
    
    
    // This is used with the class below to configure firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    
    // The body of the app
    var body: some Scene {
        
        
        // Allows multiple instances of the window to be created
        WindowGroup {
            
            // I will have to pass this into the LoginView
            let viewModel = AuthenticationViewModel()
            
            // The LoginView will be the view which is opened when the app is launched
            LoginView()
                .environmentObject(viewModel)
        }
    }
}


// Class to configure firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    
    
    // When the app is launched it configures Firebase
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Firebase configures
        FirebaseApp.configure()
        
        // Return once firebase is configured
        return true
    }
}
