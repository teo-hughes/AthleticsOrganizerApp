 //
 //  LoginView.swift
 //  AthleticsOrganizerApp
 //
 //  Created by Teo Hughes on 18/09/2021.
 //

 import SwiftUI
 import FirebaseAuth


 
 struct LoginView: View {

    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
     var body: some View {
        NavigationView {
            if viewModel.signedIn {
                VStack {
                    Text("You are signed in")
                    
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("Sign Out")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                    
                }
                
            } else {
                SignInView()
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
     }
 }
 
 
 struct SignInView: View {
    
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
     var body: some View {
        VStack {
            Image("TempLoginImage")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                
            VStack {
                TextField("Email Address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                        
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    
                Button(action: {
                        
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                        
                    viewModel.signIn(email: email, password: password)
                        
                }, label: {
                    Text("Sign In")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(8)
                        .background(Color.blue)
                            
                })
                
                NavigationLink("Create Account", destination: SignUpView())
                    .padding()
                        
            }
            .padding()
            Spacer()
        }
        .navigationTitle("Sign In")
     }
 }

 struct SignUpView: View {
    
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
     var body: some View {
        VStack {
            Image("TempLoginImage")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                
            VStack {
                TextField("Email Address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                        
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    
                Button(action: {
                        
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                        
                    viewModel.signUp(email: email, password: password)
                        
                }, label: {
                    Text("Create Account")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(8)
                        .background(Color.blue)
                            
                })
                        
            }
            .padding()
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
