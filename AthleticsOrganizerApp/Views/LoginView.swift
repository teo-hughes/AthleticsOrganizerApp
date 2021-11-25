 //
 //  LoginView.swift
 //  AthleticsOrganizerApp
 //
 //  Created by Teo Hughes on 18/09/2021.
 //
 
 
 // Importing SwiftUI
 import SwiftUI
 
 
 // This View is what is loaded when the app is launched and allows individuals to log in or not
 struct LoginView: View {
    
    
    // Accesses the AuthenticationViewModel
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    
    // The body of the LoginView
    var body: some View {
        
        
        // A NavigationView allows us to alternate between SignInView and SignUpView
        NavigationView {
            
            // If you have successfully signed in
            if viewModel.signedIn {
                
                // Display the MenuView
                MenuView()
                
                // If you still have to sign in
            } else {
                
                // Display the SignInView
                SignInView()
            }
        }
        .edgesIgnoringSafeArea(.top)
        // UI of the NavigationView (allows it to work on an iPad)
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
 }
