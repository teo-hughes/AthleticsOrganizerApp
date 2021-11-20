//
//  SignUpView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 11/11/2021.
//


// Importing SwiftUI
import SwiftUI


// This is the view which allows users to create an account
struct SignUpView: View {
    
    
    // Variables to hold the email and password
    @State var email = ""
    @State var password = ""
    
    @State private var presentAlert = false
    
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
                    
                    // If the viewModel failed to sign up show an Alert
                    if viewModel.signedIn == false && viewModel.signUpErrorMessage != "" {
                        presentAlert = true
                    }
                }, label: {
                    
                    // The UI of the button
                    Text("Create Account")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(8)
                        .background(Color.blue)
                    
                })
                // Alert shown with error Message
                .alert(isPresented: $presentAlert) {
                    // Error message shown with the error firebase returned
                    Alert(title: Text("Sign Up Failed"), message: Text("\(viewModel.signUpErrorMessage)"), dismissButton: .default(Text("OK")))
                }
            }
            .padding()
            
            // Moves the VStacks to the top
            Spacer()
        }
        .navigationTitle("Create Account")
    }
}
