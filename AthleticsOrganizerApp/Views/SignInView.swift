//
//  SignInView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 11/11/2021.
//


// Importing SwiftUI
import SwiftUI


// This is the view which allows users to sign in
struct SignInView: View {
    
    
    // Variables to hold the email and password
    @State var email = ""
    @State var password = ""
    
    @State private var presentAlert = false
    
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
                    
                    // If the viewModel failed to sign up show an Alert
                    if viewModel.signedIn == false && viewModel.signInErrorMessage != "" {
                        presentAlert = true
                    }
                    
                }, label: {
                    
                    // UI of button
                    Text("Sign In")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(8)
                        .background(Color.blue)
                    
                })
                // Alert shown with error Message
                .alert(isPresented: $presentAlert) {
                    // Error message shown with the error firebase returned
                    Alert(title: Text("Sign In Failed"), message: Text("\(viewModel.signInErrorMessage)"), dismissButton: .default(Text("OK")))
                }
                
                // Seperate button to send you to the SignUpView
                NavigationLink("Create Account", destination: SignUpView())
                    .padding()
            }
            .padding()
            
            // Moves the VStacks to the top
            Spacer()
        }
        .navigationTitle("Sign In")
    }
}
