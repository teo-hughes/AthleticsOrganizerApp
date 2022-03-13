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
    
    // Variables which will store the errors and if user is signed in
    @Published var signedIn = false
    @Published var signInErrorMessage = ""
    @Published var signUpErrorMessage = ""
    
    // Variable which finds out if the user was signed in
    var isSignedIn: Bool {
        return auth.currentUser !=  nil
    }
    
    
    // Function to sign in which takes parameters email and password, both as strings
    func signIn(email: String, password: String) {
        
        // Signs in using the firebase function
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            
            // Check if there are no errors and there is a result
            guard result != nil, error == nil else {
                
                // Set the error message to the description of the error and signedIn is still false
                self?.signInErrorMessage = "\(error?.localizedDescription ?? "")"
                self?.signedIn = false
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
        
        // Signs up using the firebase function
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            
            // Check if there are no errors and there is a result
            guard result != nil, error == nil else {
                
                // Set the error message to the description of the error and signedIn is still false
                self?.signUpErrorMessage = "\(error?.localizedDescription ?? "")"
                self?.signedIn = false
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
