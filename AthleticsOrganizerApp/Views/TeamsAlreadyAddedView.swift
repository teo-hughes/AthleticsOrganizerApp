//
//  TeamsAlreadyAddedView.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 22/11/2021.
//

import SwiftUI

struct TeamsAlreadyAddedView: View {
    
    @State var tournament: Tournament
    @State var name: String
    @State var viewModel: AthleteViewModel
    @State private var presentAlert = false
    
    var body: some View {
        
        HStack {
            Text(name)
                .padding()
            Spacer()
            Button(action: {
                presentAlert.toggle()
            }, label: {
                Text("Delete")
            })
            .alert(isPresented: $presentAlert) {
                Alert(title: Text("Delete \(name)"), message: Text("Deleting will permanently remove the team and all the athletes inside it"), primaryButton: .destructive(Text("Delete")) {
                    var indexes : [Int] = []
                    
                    for i in 0..<viewModel.athletes.count  {
                        if viewModel.athletes[i].team == name {
                            indexes.append(i)
                            
                        }
                    }
                    
                    var step = 0
                    for i in indexes {
                        viewModel.athletes.remove(at: i - step)
                        step += 1
                    }
                    
                    let ind = viewModel.teams.firstIndex(of: name) ?? 0
                    viewModel.teams.remove(at: ind)

                }, secondaryButton: .cancel())
            }
        }
        
    }
    
}
