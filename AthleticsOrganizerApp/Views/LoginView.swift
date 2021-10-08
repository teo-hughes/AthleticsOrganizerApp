 //
 //  LoginView.swift
 //  AthleticsOrganizerApp
 //
 //  Created by Teo Hughes on 18/09/2021.
 //

 import SwiftUI
 import FirebaseAuth

 // This View is what is loaded when the app is launched and allows individuals to log in or not
 struct LoginView: View {

    // Accesses the AuthenticationViewModel
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
     // The body of the LoginView
     var body: some View {
        
        // A NavigationView allows us to alternate between signing in and creating an account
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
        // UI of the NavigationView (allows it to work on an iPad)
        .navigationViewStyle(StackNavigationViewStyle())
        // When the app is launched the value of signedIn is set to false
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
     }
 }
 
 
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

 struct LoginView_Previews: PreviewProvider {
     static var previews: some View {
         LoginView()
     }
 }
