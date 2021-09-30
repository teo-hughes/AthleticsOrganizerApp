//
//  MenuView.swift
//  AthleticsOrganizerApp
//
//  Created by Teo Hughes on 18/09/2021.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        
        GeometryReader { geometry in
            VStack{
                HStack {
                    TabBarIcon(width: geometry.size.width/2, height: geometry.size.height/32, systemIconName: "house", tabName: "Home")
                    TabBarIcon(width: geometry.size.width/2, height: geometry.size.height/32, systemIconName: "info.circle", tabName: "Info")
                }
                .frame(width: geometry.size.width, height: geometry.size.height/8)
                .background(Color.gray)

                Spacer()
                Text("Tournaments")
                Spacer()
                HStack {
                    TabBarIcon(width: geometry.size.width/2, height: geometry.size.height/32, systemIconName: "list.bullet.indent", tabName: "Tournaments")
                    TabBarIcon(width: geometry.size.width/2, height: geometry.size.height/32, systemIconName: "person.crop.circle", tabName: "Your Analysis")
                }
                .frame(width: geometry.size.width, height: geometry.size.height/8)
                .background(Color.gray)
            }
            .edgesIgnoringSafeArea(.vertical)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct TabBarIcon: View {
    
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
    }
}
