//
//  MenuView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 18/09/2021.
//

import SwiftUI

struct MenuView: View {
    
    // Accessing the data from the ViewOrganizer class
    @StateObject var viewOrganizer = ViewOrganizer()
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        
        // To do (comments)
        GeometryReader { geometry in
            VStack{
                
                switch viewOrganizer.currentView {
                case .home:
                    Text("Home")
                case .tournaments:
                    Text("Tournaments")
                case .analysis:
                    Text("Analysis")
                case .info:
                    Text("Info")
                case .signOut:
                    Text("Sign Out")
                }
                
                /*
                HStack {
                    TabBarIcon(viewOrganizer: viewOrganizer, assignedView: .home, width: geometry.size.width/5, height: geometry.size.height/32, systemIconName: "house", tabName: "Home")
                    TabBarIcon(viewOrganizer: viewOrganizer, assignedView: .info, width: geometry.size.width/5, height: geometry.size.height/32, systemIconName: "info.circle", tabName: "Info")
                    TabBarIcon(viewOrganizer: viewOrganizer, assignedView: .tournaments, width: geometry.size.width/5, height: geometry.size.height/32, systemIconName: "list.bullet.indent", tabName: "Tournaments")
                    TabBarIcon(viewOrganizer: viewOrganizer, assignedView: .analysis, width: geometry.size.width/5, height: geometry.size.height/32, systemIconName: "person.crop.circle", tabName: "Your Analysis")
                    TabBarIcon(viewOrganizer: viewOrganizer, assignedView: .signOut, width: geometry.size.width/5, height: geometry.size.height/32, systemIconName: "info.circle", tabName: "Sign Out")
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height/8)
                .background(Color.gray).shadow(radius: 2)

                Spacer()
                */
                
                Spacer()
                HStack {
                    TabBarIcon(viewOrganizer: viewOrganizer, assignedView: .home, width: geometry.size.width/5, height: geometry.size.height/32, systemIconName: "house", tabName: "Home")
                    TabBarIcon(viewOrganizer: viewOrganizer, assignedView: .info, width: geometry.size.width/5, height: geometry.size.height/32, systemIconName: "info.circle", tabName: "Info")
                    TabBarIcon(viewOrganizer: viewOrganizer, assignedView: .tournaments, width: geometry.size.width/5, height: geometry.size.height/32, systemIconName: "list.bullet.indent", tabName: "Tournaments")
                    TabBarIcon(viewOrganizer: viewOrganizer, assignedView: .analysis, width: geometry.size.width/5, height: geometry.size.height/32, systemIconName: "person.crop.circle", tabName: "Your Analysis")
                    TabBarIcon(viewOrganizer: viewOrganizer, assignedView: .signOut, width: geometry.size.width/5, height: geometry.size.height/32, systemIconName: "info.circle", tabName: "Sign Out")
                }
                .frame(width: geometry.size.width, height: geometry.size.height/8)
                .background(Color.gray).shadow(radius: 2)
 
            }
            .edgesIgnoringSafeArea(.vertical)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(viewOrganizer: ViewOrganizer())
    }
}

struct TabBarIcon: View {
    
    @StateObject var viewOrganizer: ViewOrganizer
    let assignedView: WhichView
    
    let width, height: CGFloat
    let systemIconName, tabName: String
    
    
    var body: some View {
        VStack{
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
            Text(tabName)
                .font(.footnote)

        }
        .padding(.horizontal, -10)
        .foregroundColor(viewOrganizer.currentView == assignedView ? .blue : .black)
        .onTapGesture {
            viewOrganizer.currentView = assignedView
        }
    }
}
