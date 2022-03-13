//
//  TeamsAlreadyAddedView.swift
//  AthleticsOrganizerApp
//
//  Created by Hughes, Teo (BJH) on 22/11/2021.
//


// Importing SwiftUI
import SwiftUI


// This view will show a team and allow you to delete it
struct TeamsAlreadyAddedView: View {
    
    // Fetch the tournament, name and athlete view model as parameters
    @State var tournament: Tournament
    @State var name: String
    @State var viewModel: AthleteViewModel
    
    // Alert which will be shown if you want to delete a team
    @State private var presentAlert = false
    
    // Variable which is the mode of the alert allowing us to dismiss it
    @Binding var presentationMode: PresentationMode
    
    
    // Body of the teams already added view
    var body: some View {
    
        
        // HStack to display the UI of teams already added view
        HStack {
            
            // Show the name of the team
            Text(name)
                .padding()
            
            // Spacer to push the button to the right
            Spacer()
            
            // A button which deletes the team
            Button(action: {
                
                // Show the alert warning the user
                presentAlert.toggle()
            }, label: {
                
                // UI of button
                Text("Delete")
            })
            // Alert shown when the button is pressed
            .alert(isPresented: $presentAlert) {
                
                // Shows a message to warn the user
                Alert(title: Text("Delete \(name)"), message: Text("Deleting will permanently remove the team and all the athletes inside it"), primaryButton: .destructive(Text("Delete")) {
                    
                    // Get all the indexes of all the athletes which are in that team
                    var indexes : [Int] = []
                    for i in 0..<tournament.Athletes.count  {
                        if tournament.Athletes[i].team == name {
                            indexes.append(i)
                        }
                    }
                    
                    // Delete all the athletes which are in that team
                    var step = 0
                    for i in indexes {
                        tournament.Athletes.remove(at: i - step)
                        step += 1
                    }
                    
                    // Remove the team from the tournament
                    let ind = tournament.teams.firstIndex(of: name) ?? 0
                    tournament.teams.remove(at: ind)
                    
                    // Add the tournament to the view model
                    viewModel.athletes = tournament.Athletes
                    viewModel.teams = tournament.teams
                    
                    // Save the view model
                    viewModel.save(tournamentName: tournament.name)
                    viewModel.addTeam(tournamentName: tournament.name)
                    
                    // Dismiss the alert
                    $presentationMode.wrappedValue.dismiss()
                }, secondaryButton: .cancel())
            }
        }
    }
}
