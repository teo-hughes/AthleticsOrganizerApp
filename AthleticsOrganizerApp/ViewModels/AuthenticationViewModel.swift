//
//  AuthenticationViewModel.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 07/10/2021.
//

import Foundation
import FirebaseAuth

// This view model is used whilst signing in, signing out and creating an account
class AuthenticationViewModel: ObservableObject {
   
   // Use the authentication functions in FirebaseAuth
   let auth = Auth.auth()
   
   // Boolean variable which states whether we are signed in or not
   @Published var signedIn = false
   
   // Variable which will be true if the user is signed in and false if not
   var isSignedIn: Bool {
       return auth.currentUser != nil
   }
   
   // Function to sign in which takes parameters email and password
   func signIn(email: String, password: String) {
    
       // Signs in using the firebase function
       auth.signIn(withEmail: email, password: password) { [weak self] result, error in
           guard result != nil, error == nil else {
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
           guard result != nil, error == nil else {
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
