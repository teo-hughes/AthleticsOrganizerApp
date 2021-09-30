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
                Spacer()
                Text("Tournaments")
                Spacer()
                HStack {
                    TabBarIcon(width: geometry.size.width/3, height: geometry.size.height/28, systemIconName: "house", tabName: "Tournaments")
                    TabBarIcon(width: geometry.size.width/3, height: geometry.size.height/28, systemIconName: "person.crop.circle", tabName: "Your Analysis")
                    TabBarIcon(width: geometry.size.width/3, height: geometry.size.height/28, systemIconName: "info.circle", tabName: "Info")
                }
                .frame(width: geometry.size.width, height: geometry.size.height/8)
                .background(Color("TabBarBackground").shadow(radius: 2))
            }
            .edgesIgnoringSafeArea(.bottom)
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
            Spacer()
        }
        .padding(.horizontal, -2)
    }
}
