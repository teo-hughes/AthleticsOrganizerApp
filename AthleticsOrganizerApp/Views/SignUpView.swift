//
//  SignUpView.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 11/11/2021.
//

import SwiftUI




// This is the view which allows users to create an account
struct SignUpView: View {
    
    // Variables to hold the email and password
    @State var email = ""
    @State var password = ""
    
    // Accesses the AuthenticationViewModel
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    // The body of the SignUpView
    var body: some View {
        
        // A VStack allows you to display the image and then the textfields
        VStack {
            
            // The image displayed
            Image("TempLoginImage")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            // Seperate VStack for both TextFields
            VStack {
                
                // Textfield to input your email
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
                
                // The button which will create the account
                Button(action: {
                    
                    // If both textfields aren't empty
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    
                    // Sign up using the viewModel
                    viewModel.signUp(email: email, password: password)
                    
                }, label: {
                    
                    // The UI of the button
                    Text("Create Account")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(8)
                        .background(Color.blue)
                    
                })
            }
            .padding()
            
            // Allows the SignUp part to be at the top
            Spacer()
        }
        .navigationTitle("Create Account")
    }
}

