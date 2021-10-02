 //
 //  LoginView.swift
 //  AthleticsOrganizerApp
 //
 //  Created by Teo Hughes on 18/09/2021.
 //

 import SwiftUI

 struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    
     var body: some View {
        NavigationView {
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
        .navigationViewStyle(StackNavigationViewStyle())
        
     }
 }

 struct LoginView_Previews: PreviewProvider {
     static var previews: some View {
         LoginView()
     }
 }
