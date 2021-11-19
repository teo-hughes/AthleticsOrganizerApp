//
//  AuthenticationViewModel.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 07/10/2021.
//


// Importing FirebaseAuth to connect to the Firebase Authentication
import FirebaseAuth


// This view model is used whilst signing in, signing out and creating an account
class AuthenticationViewModel: ObservableObject {
    
    
    // Use the authentication functions in FirebaseAuth
    let auth = Auth.auth()
    
    // Variables which will store the error and if user is signed in
    @Published var signedIn = false
    @Published var signUpErrorMessage = ""
    
    // Variable which will be true if the user is signed in and false if not
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    
    // Function to sign in which takes parameters email and password, both as strings
    func signIn(email: String, password: String) {
        
        // Signs in using the firebase function
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                // error while signing in, e.g. incorrect password
                // TO DO - link to UI
                print("Error signing in")
                return
            }
            
            // Sets SignedIn to true
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    
    // Function to sign up which takes parameters email and password
    func signUp(email: String, password: String) {
        
        // Signs in using the firebase function
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            
            // Check if there are no errors and there is a result
            guard result != nil, error == nil else {
                
                // Set the error message to the description of the error
                self?.signUpErrorMessage = "\(error?.localizedDescription ?? "")"
                return
            }
            
            // Sets SignedIn to true
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    
    // Function to sign out
    func signOut() {
        
        // Signs out using the firebase function
        try? auth.signOut()
        
        // Sets SignedIn to false
        self.signedIn = false
    }
}
