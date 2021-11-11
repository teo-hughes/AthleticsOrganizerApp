//
//  SignInView.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 11/11/2021.
//

import SwiftUI


// This is the view which allows users to sign in
struct SignInView: View {
    
    // Variables to hold the email and password
    @State var email = ""
    @State var password = ""
    
    // Accesses the AuthenticationViewModel
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    // The body of the SignInView
    var body: some View {
        
        // A VStack allows you to display the image and then the textfields
        VStack {
            
            // Image displayed
            Image("TempLoginImage")
            // UI of image
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            // Seperate VStack for both TextFields
            VStack {
                
                // Text field to input your email
                TextField("Email Address", text: $email)
                // Disable autocorrect and autocapitalize
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                // SecureField means the password is not visible when typed in
                SecureField("Password", text: $password)
                // Disable autocorrect and autocapitalize
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                // The button which will sign you in
                Button(action: {
                    
                    // If both textfields aren't empty
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    
                    // Sign in using the viewModel
                    viewModel.signIn(email: email, password: password)
                    
                }, label: {
                    
                    // UI of button
                    Text("Sign In")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(8)
                        .background(Color.blue)
                    
                })
                
                // Seperate button to send you to the SignUpView
                NavigationLink("Create Account", destination: SignUpView())
                    .padding()
            }
            .padding()
            
            // So the sign in part is at the tap
            Spacer()
        }
        .navigationTitle("Sign In")
    }
}
