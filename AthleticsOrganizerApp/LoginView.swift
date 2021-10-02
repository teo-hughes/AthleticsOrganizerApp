 //
 //  LoginView.swift
 //  AthleticsOrganizerApp
 //
 //  Created by Teo Hughes on 18/09/2021.
 //

 import SwiftUI
 import FirebaseAuth

 class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
        }
    }

    
 }
 
 
 struct LoginView: View {

    
    @EnvironmentObject var viewModel: AppViewModel
    
     var body: some View {
        NavigationView {
            SignInView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
     }
 }
 
 
 struct SignInView: View {
    
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
     var body: some View {
        VStack {
            Image("TempLoginImage")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                
            VStack {
                TextField("Email Address", text: $email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                        
                SecureField("Password", text: $password)
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
                        
            }
            .padding()
            Spacer()
        }
        .navigationTitle("Sign in")
     }
 }


 struct LoginView_Previews: PreviewProvider {
     static var previews: some View {
         LoginView()
     }
 }
